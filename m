Return-Path: <linux-kernel+bounces-18823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0179B826398
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 10:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FB921F21C2D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 09:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78EF12B78;
	Sun,  7 Jan 2024 09:33:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail115-69.sinamail.sina.com.cn (mail115-69.sinamail.sina.com.cn [218.30.115.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A16C12B60
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.153])
	by sina.com (10.75.12.45) with ESMTP
	id 659A6FC500005B19; Sun, 7 Jan 2024 17:32:59 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8220531457961
X-SMAIL-UIID: 970FDAB88DFD4B06AB179AC15F75372A-20240107-173259-1
From: Hillf Danton <hdanton@sina.com>
To: Wesley Cheng <quic_wcheng@quicinc.com>
Cc: mathias.nyman@intel.com,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH v12 19/41] ALSA: usb-audio: qcom: Introduce QC USB SND offloading support
Date: Sun,  7 Jan 2024 17:32:43 +0800
Message-Id: <20240107093243.3225-1-hdanton@sina.com>
In-Reply-To: <20240102214549.22498-20-quic_wcheng@quicinc.com>
References: <20240102214549.22498-1-quic_wcheng@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2 Jan 2024 13:45:27 -0800 Wesley Cheng <quic_wcheng@quicinc.com>
> +/**
> + * qc_usb_audio_offload_probe() - platform op connect handler
> + * @chip: USB SND device
> + *
> + * Platform connect handler when a USB SND device is detected. Will
> + * notify SOC USB about the connection to enable the USB ASoC backend
> + * and populate internal USB chip array.
> + *
> + */
> +static void qc_usb_audio_offload_probe(struct snd_usb_audio *chip)
> +{
> +	struct usb_device *udev = chip->dev;
> +	struct snd_soc_usb_device *sdev;
> +	struct xhci_sideband *sb;
> +
> +	/*
> +	 * If there is no priv_data, the connected device is on a USB bus
> +	 * that doesn't support offloading.  Avoid populating entries for
> +	 * this device.
> +	 */
> +	if (!snd_soc_usb_find_priv_data(usb_get_usb_backend(udev)))
> +		return;
> +
> +	mutex_lock(&chip->mutex);
> +	if (!uadev[chip->card->number].chip) {
> +		sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
> +		if (!sdev)
> +			goto exit;
> +
> +		sb = xhci_sideband_register(udev);
> +		if (!sb)
> +			goto free_sdev;
> +	} else {
> +		sb = uadev[chip->card->number].sb;
> +		sdev = uadev[chip->card->number].sdev;
> +	}
> +
> +	mutex_lock(&qdev_mutex);
> +	if (!uaudio_qdev)
> +		qc_usb_audio_offload_init_qmi_dev(udev);
> +
> +	atomic_inc(&uaudio_qdev->qdev_in_use);
> +	mutex_unlock(&qdev_mutex);
> +
> +	uadev[chip->card->number].sb = sb;
> +	uadev[chip->card->number].chip = chip;

Protecting uadev[] with a non global lock makes no sense.
> +
> +	sdev->card_idx = chip->card->number;
> +	sdev->chip_idx = chip->index;
> +	uadev[chip->card->number].sdev = sdev;
> +
> +	uaudio_qdev->last_card_num = chip->card->number;
> +	snd_soc_usb_connect(usb_get_usb_backend(udev), sdev);
> +
> +	mutex_unlock(&chip->mutex);
> +
> +	return;
> +
> +free_sdev:
> +	kfree(sdev);
> +exit:
> +	mutex_unlock(&chip->mutex);
> +}
> +
> +/**
> + * qc_usb_audio_offload_disconnect() - platform op disconnect handler
> + * @chip: USB SND device
> + *
> + * Platform disconnect handler.  Will ensure that any pending stream is
> + * halted by issuing a QMI disconnect indication packet to the adsp.
> + *
> + */
> +static void qc_usb_audio_offload_disconnect(struct snd_usb_audio *chip)
> +{
> +	struct qmi_uaudio_stream_ind_msg_v01 disconnect_ind = {0};
> +	struct uaudio_qmi_svc *svc = uaudio_svc;
> +	struct uaudio_dev *dev;
> +	int card_num;
> +	int ret;
> +
> +	if (!chip)
> +		return;
> +
> +	card_num = chip->card->number;
> +	if (card_num >= SNDRV_CARDS)
> +		return;
> +
> +	mutex_lock(&qdev_mutex);
> +	mutex_lock(&chip->mutex);

Lock order looks correct here.

> +	dev = &uadev[card_num];
> +
> +	/* Device has already been cleaned up, or never populated */
> +	if (!dev->chip) {
> +		mutex_unlock(&qdev_mutex);
> +		mutex_unlock(&chip->mutex);
> +		return;
> +	}
> +
> +	/* cleaned up already */
> +	if (!dev->udev)
> +		goto done;
> +
> +	if (atomic_read(&dev->in_use)) {
> +		mutex_unlock(&chip->mutex);
> +		mutex_unlock(&qdev_mutex);
> +		dev_dbg(uaudio_qdev->data->dev,
> +			"sending qmi indication disconnect\n");
> +		disconnect_ind.dev_event = USB_QMI_DEV_DISCONNECT_V01;
> +		disconnect_ind.slot_id = dev->udev->slot_id;
> +		disconnect_ind.controller_num = dev->usb_core_id;
> +		disconnect_ind.controller_num_valid = 1;
> +		ret = qmi_send_indication(svc->uaudio_svc_hdl, &svc->client_sq,
> +				QMI_UAUDIO_STREAM_IND_V01,
> +				QMI_UAUDIO_STREAM_IND_MSG_V01_MAX_MSG_LEN,
> +				qmi_uaudio_stream_ind_msg_v01_ei,
> +				&disconnect_ind);
> +		if (ret < 0)
> +			dev_err(uaudio_qdev->data->dev,
> +				"qmi send failed with err: %d\n", ret);
> +
> +		ret = wait_event_interruptible_timeout(dev->disconnect_wq,
> +				!atomic_read(&dev->in_use),
> +				msecs_to_jiffies(DEV_RELEASE_WAIT_TIMEOUT));
> +		if (!ret) {
> +			dev_err(uaudio_qdev->data->dev,
> +				"timeout while waiting for dev_release\n");
> +			atomic_set(&dev->in_use, 0);
> +		} else if (ret < 0) {
> +			dev_err(uaudio_qdev->data->dev,
> +				"failed with ret %d\n", ret);
> +			atomic_set(&dev->in_use, 0);
> +		}
> +		mutex_lock(&qdev_mutex);
> +		mutex_lock(&chip->mutex);
> +	}
> +
> +	uaudio_dev_cleanup(dev);
> +done:
> +	/*
> +	 * If num_interfaces == 1, the last USB SND interface is being removed.
> +	 * This is to accommodate for devices w/ multiple UAC functions.
> +	 */
> +	if (chip->num_interfaces == 1) {
> +		snd_soc_usb_disconnect(usb_get_usb_backend(chip->dev), dev->sdev);
> +		xhci_sideband_unregister(dev->sb);
> +		dev->chip = NULL;
> +		kfree(dev->sdev);
> +		dev->sdev = NULL;
> +	}
> +	mutex_unlock(&chip->mutex);
> +
> +	atomic_dec(&uaudio_qdev->qdev_in_use);
> +	if (!atomic_read(&uaudio_qdev->qdev_in_use))
> +		qc_usb_audio_cleanup_qmi_dev();
> +
> +	mutex_unlock(&qdev_mutex);
> +}

