Return-Path: <linux-kernel+bounces-19340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D9C826BAA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E8FF1C2206E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C11B13FF0;
	Mon,  8 Jan 2024 10:39:14 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-m608.netease.com (mail-m608.netease.com [210.79.60.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFEE13FF6;
	Mon,  8 Jan 2024 10:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=senarytech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=senarytech.com
Received: from liubo (unknown [61.183.143.78])
	by mail-m12756.qiye.163.com (Hmail) with ESMTPA id 8C244DC05F0;
	Mon,  8 Jan 2024 11:29:50 +0800 (CST)
From: =?gb2312?B?wfWyqQ==?= <bo.liu@senarytech.com>
To: "'Takashi Iwai'" <tiwai@suse.de>
Cc: <perex@perex.cz>,
	<tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA: hda/conexant: Fix headset auto detect fail in cx8070 and SN6140
Date: Mon, 8 Jan 2024 11:29:51 +0800
Message-ID: <002401da41e2$f159f5f0$d40de1d0$@senarytech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdpB4vBlAuC7K9/cRVGMODF0aT21Gg==
Content-Language: zh-cn
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTksYVkwdGBhISB9KQkhOGVUTARMWGhIXJBQOD1
	lXWRgSC1lBWU1KVUpDSFVKT0hVTENZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8ce71e9649b223kuuu8c244dc05f0
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NC46Ghw4AzwdTTI2LzAsGiJJ
	QlZPCUlVSlVKTEtPTUNPTkJKTkxMVTMWGhIXVRkUVRcSDjsIHhUaCQIPHhgTVRgUFkVZV1kSC1lB
	WU1KVUpDSFVKT0hVTENZV1kIAVlBTElLTzcG

hi Takashi Iwai,
	Thank you very much for your patient guidance. Below is the reply to
the question, please kindly correct it, thanks.

> +static void cx_fixup_headset_recog(struct hda_codec *codec) {
> +	unsigned int mic_persent;
> +
> +	/* fix some headset type recognize fail issue, such as EDIFIER
headset */
> +	snd_hda_codec_write(codec, 0x1c, 0, 0x320, 0x010);
> +	snd_hda_codec_write(codec, 0x1c, 0, 0x3b0, 0xe10);
> +	snd_hda_codec_write(codec, 0x1c, 0, 0x4f0, 0x0eb);

Please use the defined verbs in sound/hda_verbs.h.
The arguments (0x320, 0x010) are (AC_VERB_SET_AMP_GAIN_MUTE, 0x2010) =
etc.

Re: (0x1c, 0x320) is not amp gain register, but vendor defined register =
as
rx control register. Use AC_VERB_SET_AMP_GAIN_MUTE will confused. It's
similar to 0x4f0 and 0xca0.

Also, it's still not clear what if other nodes are used for headphone =
and
mic pins -- or when either only headphone or only mic is present.
A rare case, but we need to cover.

Re: in cx8070 and sn6140, only 0x16 and 0x19 can be used together as
headset. Other nodes can be used separately as headphones or =
microphones,
but not as headset,=20
so their configuration will not interfere with the type detection of
headset.

> +	/* fix reboot headset type recognize fail issue */
> +	mic_persent =3D snd_hda_codec_read(codec, 0x19, 0,
AC_VERB_GET_PIN_SENSE, 0x0);
> +	if (mic_persent&0x80000000)

A coding style problem.  Similar issues seen in a few other places, too.
Consult scripts/checkpatch.pl.

Re: was & need space? I have checked with scripts/checkpatch.pl before
submitting the patch and there are no warnings or errors.

> +static void cx_process_headset_plugin(struct hda_codec *codec) {
> +	unsigned int val;
> +	unsigned int count =3D 0;
> +
> +	/* Wait headset detect done. */
> +	do {
> +		val =3D snd_hda_codec_read(codec, 0x1c, 0, 0xca0, 0x0);

Use the verb: AC_VERB_GET_PROC_COEF, 0xa000.
At best, define the COEF values 0xa000 and 0xb000, and the corresponding
value bits, too.

Re: (0x1c, 0xca0) is not COEF register, but vendor defined register as
jacksense register.

> +static void cx_update_headset_mic_vref(struct hda_codec *codec,=20
> +unsigned int res) {
> +	unsigned int phone_present, mic_persent, phone_tag, mic_tag;
> +	struct conexant_spec *spec =3D codec->spec;
> +
> +	/* In cx8070 and sn6140, headset is fixed to use node 16 and node
19.

Is it really guaranteed?  IMO, we should check the pin configs =
beforehand at
the parsing time.

Re: in cx8070 and sn6140, only 0x16 and 0x19 can be used together as
headset. The node 16 can only be config to headphone or disable,
The node 19 can only be config to microphone or disable. Only node 16 =
and
node 19 both enable, the patch will process.

Best Regards
Bo Liu
=A1=A1
-----=D3=CA=BC=FE=D4=AD=BC=FE-----
=B7=A2=BC=FE=C8=CB: Takashi Iwai <tiwai@suse.de>=20
=B7=A2=CB=CD=CA=B1=BC=E4: 2024=C4=EA1=D4=C26=C8=D5 1:02
=CA=D5=BC=FE=C8=CB: bo liu <bo.liu@senarytech.com>
=B3=AD=CB=CD: perex@perex.cz; tiwai@suse.com; =
linux-sound@vger.kernel.org;
linux-kernel@vger.kernel.org
=D6=F7=CC=E2: Re: [PATCH] ALSA: hda/conexant: Fix headset auto detect =
fail in cx8070
and SN6140

On Thu, 04 Jan 2024 12:10:44 +0100,
bo liu wrote:
>=20
> When OMTP headset plugin the headset jack of CX8070 and SN6160 sound=20
> cards, the headset type detection circuit will recognize the headset =
type
as CTIA.
> At this point, plugout and plugin the headset will get the correct=20
> headset type as OMTP.
> The reason for the failure of headset type recognition is that the=20
> sound card creation will enable the VREF voltage of the headset mic,=20
> which interferes with the headset type automatic detection circuit.=20
> Plugout and plugin the headset will restart the headset detection and=20
> get the correct headset type.
> The patch is disable the VREF voltage when the headset is not present, =

> and will enable the VREF voltage when the headset is present.
>=20
> Signed-off-by: bo liu <bo.liu@senarytech.com>

Please put the revision number to the subject prefix, i.e.
"Subject: [PATCH v3] ALSA: hda/conexant: ...."

> +static void cx_fixup_headset_recog(struct hda_codec *codec) {
> +	unsigned int mic_persent;
> +
> +	/* fix some headset type recognize fail issue, such as EDIFIER
headset */
> +	snd_hda_codec_write(codec, 0x1c, 0, 0x320, 0x010);
> +	snd_hda_codec_write(codec, 0x1c, 0, 0x3b0, 0xe10);
> +	snd_hda_codec_write(codec, 0x1c, 0, 0x4f0, 0x0eb);

Please use the defined verbs in sound/hda_verbs.h.
The arguments (0x320, 0x010) are (AC_VERB_SET_AMP_GAIN_MUTE, 0x2010) =
etc.

Also, it's still not clear what if other nodes are used for headphone =
and
mic pins -- or when either only headphone or only mic is present.
A rare case, but we need to cover.

> +	/* fix reboot headset type recognize fail issue */
> +	mic_persent =3D snd_hda_codec_read(codec, 0x19, 0,
AC_VERB_GET_PIN_SENSE, 0x0);
> +	if (mic_persent&0x80000000)

A coding style problem.  Similar issues seen in a few other places, too.
Consult scripts/checkpatch.pl.

> +enum {
> +	CX_HEADSET_NOPRESENT =3D 0,
> +	CX_HEADSET_PARTPRESENT,
> +	CX_HEADSET_ALLPRESENT,
> +};

This should be defined earlier.  You can use the enum type for
spec->headset_present_flag, too.

> +static void cx_process_headset_plugin(struct hda_codec *codec) {
> +	unsigned int val;
> +	unsigned int count =3D 0;
> +
> +	/* Wait headset detect done. */
> +	do {
> +		val =3D snd_hda_codec_read(codec, 0x1c, 0, 0xca0, 0x0);

Use the verb: AC_VERB_GET_PROC_COEF, 0xa000.
At best, define the COEF values 0xa000 and 0xb000, and the corresponding
value bits, too.

> +static void cx_update_headset_mic_vref(struct hda_codec *codec,=20
> +unsigned int res) {
> +	unsigned int phone_present, mic_persent, phone_tag, mic_tag;
> +	struct conexant_spec *spec =3D codec->spec;
> +
> +	/* In cx8070 and sn6140, headset is fixed to use node 16 and node
19.

Is it really guaranteed?  IMO, we should check the pin configs =
beforehand at
the parsing time.


thanks,

Takashi


