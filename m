Return-Path: <linux-kernel+bounces-101195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D8787A3DC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30A111F221BE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6680E18629;
	Wed, 13 Mar 2024 08:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O9dyeS+X"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0700A1B7F3
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 08:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710316999; cv=none; b=UvBlwzUYVKtss2NgYGujE7gO9yfibXM+4ESdUn8YIG0hIfwGVWAXkRUwO/f5p6PlYdkceYei8/XmHGjfH4Nz9H15ED9MP1hHLra4MGeSx0rzOwDaVKmoU8RYoFkpw5uzaoG/0mMES7FfARpSy9G7hfSTOp1+S4xn71w3oMSC/1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710316999; c=relaxed/simple;
	bh=gRShenHCxcdnTK7K1mCY4h67piQzQmbBm3y5WMxRGlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=llIkT1YThcJ6Z/S+LAT7RIKngkSjMPimgBGSja2s1Pr3tBZcKLFVNAUw+ghKM8ln8sQz56B5rVJwuMCTTizll/M+oeIuj+QuHweqFZmyzjFQ0NXZYzzHqWb/rOpiDr4mHf4Fs15gsIG65LYjDS8cb2jhx0OQL2tdqhl/wYMofkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O9dyeS+X; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4645485da6so203550166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710316996; x=1710921796; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+2ehdSyGG7YinOeMSH1X38eE2SpnsnmuopiJfznP8Q4=;
        b=O9dyeS+XEjtAK4nLYIAVQxRNqHIZ3zkKwPOtZmODDySStocLPl1X6ygweXVDRu8rV1
         Bug0yu21KClgqMYWB+CXVt6mJuUzQfnZDTP6Iy3cIyp7CPIQsw8ZbA9WzLSX/BNnZB2d
         0yFols5AWBKW9o7XiH0RBiQNba6qvBHtn2hz0ISL+lqC33yy9jUZAZMW66K1PeDEYlUA
         jsCbK3j5kpdGQK8X6o6HjrV19fJilWh0yNxh44yQYRJnTtS3DfQZOhopieCzat4i+2Fu
         zMvhPBcEHq+GIuBXCh6nWL/QgTiEkfiVUP4SfHgsmNUg19ILnyfnBOHZheX//jd0kY8p
         YS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710316996; x=1710921796;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+2ehdSyGG7YinOeMSH1X38eE2SpnsnmuopiJfznP8Q4=;
        b=ccY/y7JVYTA0sDq4MUczyaFGR7TkJVA8ZUaoSAGc58rKXHzWNUW4t/fSr+pARqL7mJ
         Fchsl7pOzo6aftfdUuUnnAZypV+Bg49tVFQg8n53JreuU0IJPRWhHNfIhTPJRmbjBPLp
         5EVW/ipg1+t/JZ9oYgUys0TOurxhFebZSzf/oAKLpg8yBsXbdmULb9DvbBWKYdk49d8p
         UdJK2LKIO696mtsZ1SofXdeGdQP9SaViWW7OkVmL+K/2vtd/68zc/qATshSR75IaLHhA
         6ezHIjHnYPZWRaSqLOJnBeiPZwTXs8pbwpaQ86yR7xMBx9/W/ypuGq3Z4yUpIc2Grvcr
         ZTew==
X-Forwarded-Encrypted: i=1; AJvYcCU1im3lc0kGt6EZlrHUWakhLobzntLjqVaHfdrL/fwzHj+67v/xAgUf2mqx2JXfYH+eAxSTu+vN0Hcqde1VeUKy+Lfp+S9LBWs4iWJb
X-Gm-Message-State: AOJu0Yyk4XUZ0QAgNcCGV37N+AGoG2YLsDZY9B0EDOUTiqVSJsbMrW8M
	9YjjT27Zx7MiPD4xhNsR7ZnE2PWTTq6JBL1vSaE4k7LKpGpOi4hfvAukJRmCrJX8S+AdXH0wpo+
	HoT3nKrVep1dPJYk32Z5T3ceNTYL3Vd8jwkmg
X-Google-Smtp-Source: AGHT+IFePtdXxi6l/ot35dlK/aWa1JrNLiMXU14TYRiwdZwUw/7eG/+kSYyAzAFXWIWYs6eWT26Q4L0fnUiQ37J4W6Y=
X-Received: by 2002:a17:906:6a10:b0:a45:f371:c109 with SMTP id
 qw16-20020a1709066a1000b00a45f371c109mr9733432ejc.24.1710316996074; Wed, 13
 Mar 2024 01:03:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228013619.29758-1-quic_wcheng@quicinc.com> <20240228013619.29758-21-quic_wcheng@quicinc.com>
In-Reply-To: <20240228013619.29758-21-quic_wcheng@quicinc.com>
From: Albert Wang <albertccwang@google.com>
Date: Wed, 13 Mar 2024 16:03:03 +0800
Message-ID: <CANqn-rjTgHgzssxZiuwvTKzOS31wzjS4Y9G-XacZN4a7c82MaA@mail.gmail.com>
Subject: Re: [PATCH v18 20/41] ALSA: usb-audio: qcom: Introduce QC USB SND
 offloading support
To: Wesley Cheng <quic_wcheng@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, mathias.nyman@intel.com, perex@perex.cz, 
	conor+dt@kernel.org, corbet@lwn.net, lgirdwood@gmail.com, 
	andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com, broonie@kernel.org, 
	bgoswami@quicinc.com, tiwai@suse.com, robh+dt@kernel.org, 
	konrad.dybcio@linaro.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-doc@vger.kernel.org, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"

+/**
+ * qc_usb_audio_offload_suspend() - USB offload PM suspend handler
+ * @intf: USB interface
+ * @message: suspend type
+ *
+ * PM suspend handler to ensure that the USB offloading driver is able to stop
+ * any pending traffic, so that the bus can be suspended.
+ *
+ */
+static void qc_usb_audio_offload_suspend(struct usb_interface *intf,
+                                               pm_message_t message)
+{
+       struct qmi_uaudio_stream_ind_msg_v01 disconnect_ind = {0};
+       struct snd_usb_audio *chip = usb_get_intfdata(intf);
+       struct uaudio_qmi_svc *svc = uaudio_svc;
+       struct uaudio_dev *dev;
+       int card_num;
+       int ret;
+
+       if (!chip)
+               return;
+
+       card_num = chip->card->number;
+       if (card_num >= SNDRV_CARDS)
+               return;
+
+
+       mutex_lock(&chip->mutex);
+       dev = &uadev[card_num];
+
+       if (atomic_read(&dev->in_use)) {
+               mutex_unlock(&chip->mutex);
+               dev_dbg(uaudio_qdev->data->dev, "sending qmi
indication suspend\n");
+               disconnect_ind.dev_event = USB_QMI_DEV_DISCONNECT_V01;
+               disconnect_ind.slot_id = dev->udev->slot_id;
+               disconnect_ind.controller_num = dev->usb_core_id;
+               disconnect_ind.controller_num_valid = 1;
+               ret = qmi_send_indication(svc->uaudio_svc_hdl, &svc->client_sq,
+                               QMI_UAUDIO_STREAM_IND_V01,
+                               QMI_UAUDIO_STREAM_IND_MSG_V01_MAX_MSG_LEN,
+                               qmi_uaudio_stream_ind_msg_v01_ei,
+                               &disconnect_ind);
+               if (ret < 0)
+                       dev_err(uaudio_qdev->data->dev,
+                               "qmi send failed with err: %d\n", ret);
+
+               ret = wait_event_interruptible_timeout(dev->disconnect_wq,
+                               !atomic_read(&dev->in_use),
+                               msecs_to_jiffies(DEV_RELEASE_WAIT_TIMEOUT));
+               if (!ret) {
+                       dev_err(uaudio_qdev->data->dev,
+                               "timeout while waiting for dev_release\n");
+                       atomic_set(&dev->in_use, 0);
+               } else if (ret < 0) {
+                       dev_err(uaudio_qdev->data->dev,
+                               "failed with ret %d\n", ret);
+                               atomic_set(&dev->in_use, 0);
+               }
+               mutex_lock(&chip->mutex);
+       }
+       mutex_unlock(&chip->mutex);
+}
+

Hi Wesley,

The suspend function `qc_usb_audio_offload_suspend()` looks to stop
the traffic on the bus, so that the bus can be suspended. That allows
the application processor(AP) to enter suspend. There is a subtle
difference with our feature, which is to allow AP suspend with the
Host and USB controller active to continue the audio offloading. We
call this feature `allow AP suspend in playback`. So, I have some
points to clarify with you:
1. Will the suspend flow `usb_audio_suspend() -->
platform_ops->suspend_cb() --> qc_usb_audio_offload_suspend()` be
called when offloading is active?
2. As my understanding, the suspend function is to allow AP suspend
when the offloading is IDLE, but it won't allow AP suspend when in
playback or capture. Please correct me if anything is wrong.
3. We would like to integrate the `allow AP suspend in playback`
feature with your framework to become one upstream offload solution.
Here is the patch:
https://patchwork.kernel.org/project/linux-pm/patch/20240223143833.1509961-1-guanyulin@google.com/
.

Thanks,
Albert

