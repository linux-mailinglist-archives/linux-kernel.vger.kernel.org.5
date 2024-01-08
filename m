Return-Path: <linux-kernel+bounces-19300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBC8826B13
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD5A28290F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7023125DE;
	Mon,  8 Jan 2024 09:46:28 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-m49203.qiye.163.com (mail-m49203.qiye.163.com [45.254.49.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DB2134D3;
	Mon,  8 Jan 2024 09:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=senarytech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=senarytech.com
Received: from liubo (unknown [61.183.143.78])
	by mail-m12756.qiye.163.com (Hmail) with ESMTPA id A288CDC1402;
	Mon,  8 Jan 2024 17:45:58 +0800 (CST)
From: =?gb2312?B?wfWyqQ==?= <bo.liu@senarytech.com>
To: "'Takashi Iwai'" <tiwai@suse.de>
Cc: <perex@perex.cz>,
	<tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA: hda/conexant: Fix headset auto detect fail in cx8070 and SN6140
Date: Mon, 8 Jan 2024 17:46:00 +0800
Message-ID: <003501da4217$7cfdf4b0$76f9de10$@senarytech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdpCFyHGmgv8cbCjRkurC5slBpdJyg==
Content-Language: zh-cn
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZH01IVktPGR8YTkJKTkxDGlUTARMWGhIXJBQOD1
	lXWRgSC1lBWU1KVUpDSFVKT0hVTENZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8ce876f33db223kuuua288cdc1402
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6M1E6Ihw6QjwvHDEzGi0eFioy
	AT8wCVZVSlVKTEtPTEtMSk5CTkNOVTMWGhIXVRkUVRcSDjsIHhUaCQIPHhgTVRgUFkVZV1kSC1lB
	WU1KVUpDSFVKT0hVTENZV1kIAVlBTkhPSTcG

Hi Takashi,
	Thank you for your quick reply. I hope the following response can be
explained clearly, thanks.

> > > +	/* fix some headset type recognize fail issue, such as EDIFIER
> > headset */
> > > +	snd_hda_codec_write(codec, 0x1c, 0, 0x320, 0x010);
> > > +	snd_hda_codec_write(codec, 0x1c, 0, 0x3b0, 0xe10);
> > > +	snd_hda_codec_write(codec, 0x1c, 0, 0x4f0, 0x0eb);
> > 
> > Please use the defined verbs in sound/hda_verbs.h.
> > The arguments (0x320, 0x010) are (AC_VERB_SET_AMP_GAIN_MUTE, 0x2010)
etc.
> > 
> > Re: (0x1c, 0x320) is not amp gain register, but vendor defined 
> > register as rx control register. Use AC_VERB_SET_AMP_GAIN_MUTE will 
> > confused. It's similar to 0x4f0 and 0xca0.
>
> Ah interesting.  But the verb is actually seen as
AC_VERB_SET_AMP_GAIN_MUTE -- although the resultant bits seem invalid.
>
> HD-audio combines the verb and the value into 20 bits, e.g. (0x320,
> 0x10) is composed as 0x32010, and (0x3b0, 0xe10) is 0x3be10.
> 0x3xx is translated as SET_AMP_GAIN_MUTE, but in your case, 0x32010 leaves
0 to both the input/output bits (bits 14 and 15), which makes it as invalid.
>
> 0x3be10 is another invalid verb, which sets SET_AMP_GAIN_MUTE with OUTPUT,
but it sets both LEFT and RIGHT, and passes a high index (14).
>
> And, what actually (0x4f0, 0x0eb) does?  It's composed as 0x4f0eb, and in
this case, it's a valid verb (SET_PROC_COEF + 0xf0eb).  But COEF is
vendor-specific, so it can be translated in everything the chip wants.
>
> So, if those verbs are vendor-specific ones, please define them and/or
give proper comments to explain what they do for each.

Re: In cx8070 and sn6140, (0x1c, 0x320, 0x010) is used to set micbiasd
output current comparator 
threshold from 66% to 55%. (0x1c, 0x3b0, 0xe10) is used to set OFF voltage
for DFET from -1.2V to 
-0.8V, set headset micbias registor value adjustment trim from 2.2K ohms to
2.0K ohms.
(0x1c, 0x4f0, 0x0eb) is used to set headset detect debounce time, this will
impact detection time.
As it needs to be adjusted according to the project, i think it set to bios
may better. So I will remove
the setting from this patch.

> > Also, it's still not clear what if other nodes are used for headphone 
> > and mic pins -- or when either only headphone or only mic is present.
> > A rare case, but we need to cover.
> > 
> > Re: in cx8070 and sn6140, only 0x16 and 0x19 can be used together as 
> > headset. Other nodes can be used separately as headphones or 
> > microphones, but not as headset, so their configuration will not 
> > interfere with the type detection of headset.
>
> OK, then explain this in comments, too (that we blindly assume those
pins).

Re: OK, I will add the description to patch.

> > > +static void cx_process_headset_plugin(struct hda_codec *codec) {
> > > +	unsigned int val;
> > > +	unsigned int count = 0;
> > > +
> > > +	/* Wait headset detect done. */
> > > +	do {
> > > +		val = snd_hda_codec_read(codec, 0x1c, 0, 0xca0, 0x0);
> > 
> > Use the verb: AC_VERB_GET_PROC_COEF, 0xa000.
> > At best, define the COEF values 0xa000 and 0xb000, and the 
> > corresponding value bits, too.
> > 
> > Re: (0x1c, 0xca0) is not COEF register, but vendor defined register as 
> > jacksense register.
> > 
> > > +static void cx_update_headset_mic_vref(struct hda_codec *codec, 
> > > +unsigned int res) {
> > > +	unsigned int phone_present, mic_persent, phone_tag, mic_tag;
> > > +	struct conexant_spec *spec = codec->spec;
> > > +
> > > +	/* In cx8070 and sn6140, headset is fixed to use node 16 and node
> > 19.
> > 
> > Is it really guaranteed?  IMO, we should check the pin configs 
> > beforehand at the parsing time.
> > 
> > Re: in cx8070 and sn6140, only 0x16 and 0x19 can be used together as 
> > headset. The node 16 can only be config to headphone or disable, The 
> > node 19 can only be config to microphone or disable. Only node 16 and 
> > node 19 both enable, the patch will process.
>
> Then we still might need a check for the condition?

Re: because the node 16 and node 19 can only be config to headphone and
microphone, as describe 
before, whether node 16 and node 19 enable, the patch can process, so I
think it's no need to check
their pin configs.

Best Regards
Bo Liu


