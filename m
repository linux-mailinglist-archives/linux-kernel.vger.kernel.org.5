Return-Path: <linux-kernel+bounces-55142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7165484B85F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4DA41C23FC9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866A8132C39;
	Tue,  6 Feb 2024 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kLFOOydV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ED31E4BE;
	Tue,  6 Feb 2024 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231024; cv=none; b=ZLq5JClHXDOvF1O4Phd791iZAht+njlIPCDlOY+ehsD3ylI/X/0mQ+ItgNPZcfvDz7O6mao99iddl8yNnfRrhstupKLT5oFcsOnu1DLu2EauVPobJm14cmodz+2WaJPW27tGZpxGqiYlvfvhSD6ieSF7dcQPdgsT02SAvkZuuWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231024; c=relaxed/simple;
	bh=TRNOZ2E0jVFr1j4Jk3WeOB19Tmkl0WCO11cXpH5xx0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLehfM0Tm/ri9VGKbGbGne2qY3konLpMXzCtKnFbP9yzWeW0U0FzFJxCWO66irpNJkCcjfDyygqDAwn/qIP+50BiBOmG8pjNAM8SehKqoX9T+a3NaDuqpyaE7Bji0aCzRlMDD5fC6JW6TKxyuWWVGRGTxU0xKrVXzjiyJVE053w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kLFOOydV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742AAC433C7;
	Tue,  6 Feb 2024 14:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707231024;
	bh=TRNOZ2E0jVFr1j4Jk3WeOB19Tmkl0WCO11cXpH5xx0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kLFOOydVz8hY/tZlvFGGUr5yxRLIh5a3MMj5zIRocdMkLDC1jdALkpy9OA3M9F8lD
	 uRpBnMXQLY+8ovJ86Mu/N+WBHiVZCawbZRCXM749gkLpVYkyUjNoqP4OZx2B7X+6le
	 95uqhpXCNWzr+Hy9rLJ6CQwMVmoMMdIisEZbF31o=
Date: Tue, 6 Feb 2024 14:50:21 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Wesley Cheng <quic_wcheng@quicinc.com>, srinivas.kandagatla@linaro.org,
	mathias.nyman@intel.com, perex@perex.cz, conor+dt@kernel.org,
	corbet@lwn.net, lgirdwood@gmail.com, andersson@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, Thinh.Nguyen@synopsys.com,
	broonie@kernel.org, bgoswami@quicinc.com, tiwai@suse.com,
	robh+dt@kernel.org, konrad.dybcio@linaro.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH v13 32/53] ALSA: usb-audio: Check for support for
 requested audio format
Message-ID: <2024020617-limb-name-f852@gregkh>
References: <20240203023645.31105-1-quic_wcheng@quicinc.com>
 <20240203023645.31105-33-quic_wcheng@quicinc.com>
 <87wmrhvir7.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmrhvir7.wl-tiwai@suse.de>

On Tue, Feb 06, 2024 at 02:12:44PM +0100, Takashi Iwai wrote:
> On Sat, 03 Feb 2024 03:36:24 +0100,
> Wesley Cheng wrote:
> > 
> > Allow for checks on a specific USB audio device to see if a requested PCM
> > format is supported.  This is needed for support when playback is
> > initiated by the ASoC USB backend path.
> > 
> > Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> 
> Just cosmetic:
> 
> > +struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
> > +			struct snd_pcm_hw_params *params, int direction)
> > +{
> > +	struct snd_usb_audio *chip;
> > +	struct snd_usb_substream *subs;
> > +	struct snd_usb_stream *as;
> > +	const struct audioformat *fmt;
> > +
> > +	/*
> > +	 * Register mutex is held when populating and clearing usb_chip
> > +	 * array.
> > +	 */
> > +	mutex_lock(&register_mutex);
> > +	chip = usb_chip[card_idx];
> > +	if (!chip) {
> > +		mutex_unlock(&register_mutex);
> > +		return NULL;
> > +	}
> > +
> > +	if (enable[card_idx]) {
> > +		list_for_each_entry(as, &chip->pcm_list, list) {
> > +			subs = &as->substream[direction];
> > +			fmt = snd_usb_find_substream_format(subs, params);
> > +			if (fmt) {
> > +				mutex_unlock(&register_mutex);
> > +				return as;
> > +			}
> > +		}
> > +	}
> > +	mutex_unlock(&register_mutex);
> 
> I prefer having the single lock/unlock call pair, e.g.
> 
> 	struct snd_usb_stream *as, *ret;
> 
> 	ret = NULL;
> 	mutex_lock(&register_mutex);
> 	chip = usb_chip[card_idx];
> 	if (chip && enable[card_idx]) {
> 		list_for_each_entry(as, &chip->pcm_list, list) {
> 			subs = &as->substream[direction];
> 			if (snd_usb_find_substream_format(subs, params)) {
> 				ret = as;
> 				break;
> 			}
> 		}
> 	}
> 	mutex_unlock(&register_mutex);
> 	return ret;
> }
> 
> In this case, we shouldn't reuse "as" for the return value since it
> can be non-NULL after the loop end.

Why not just use guard(mutex) for this, making it all not an issue?

thanks,

greg k-h

