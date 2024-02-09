Return-Path: <linux-kernel+bounces-59514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6704B84F83D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A65C1C243A9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A9B6E2C1;
	Fri,  9 Feb 2024 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="u3hVr4aS"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB95692FC
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 15:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707491423; cv=none; b=tcz/arkDr3KpXd/hbOutDhaYIUOcFitEjf8+goiPgbqMC6px9UiOFcxc6q7dh+cpBcf4DyUhWIZtUN77mD3gI8yY2JCbpxgrtCIrrnPfmbsRj7L+M1TAbzNpggQj8kPCf20kN6PGl48Sjkw7Egqmaz5a5G0hEw9j4RzMoFah9dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707491423; c=relaxed/simple;
	bh=qtUK2RUPjq9zDcyg4Ds+2K42jq2xEZ+Gn6WwDqcikrs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nS10Jb1QRC3/kGmvSCCRYyZcyZXjn0/r3auGCOngxb4rwbtX8QUXZwGVLCylJEY3OMapxzuK4qQHj5dgFUuxToq2rGiCvnCiFqAJbwxKlax4mzYE6rl036+i+h0WAt4f1rshKHgCP4rWwGK3RcCa/FXCyWO35eNjYU1ooe6Eyxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=u3hVr4aS; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-785738e94b9so46622385a.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 07:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1707491420; x=1708096220; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5jZoYn0SqLJVfeFn7JEaR0g9woQE+L+0Od2YAlUn5xo=;
        b=u3hVr4aSeiXDVV7KEL5xBT7b+XrKLOH6eKjBD2ik/2BnKFAMhbFVVK6/zy/XrD2ix6
         /oLrNPGsxbP3CrJX6SqJOUqosP8+Cuk2gBS+Iu2ypZ1Z2uxflChDm0FqmqkAE4IK2OMr
         UPSTcsEY/07o90eWGpHKXPe2BJVZBm/j9jaAAs6GZ2ozeKmxWW+ADp6JgNAluj6MCKkU
         v0RRVrEeW/Xh9gb8WNI+2gPom795eFxHPIYYnNXVHYf6weXIYaizYhHxYR8eWwB8Tl24
         tyVvnS1TaNPfH9IcjljlbxaJwCYi4a8OeceEifZLAzUosHVp9l1m8mFA1mE3EWWc9mru
         fygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707491420; x=1708096220;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5jZoYn0SqLJVfeFn7JEaR0g9woQE+L+0Od2YAlUn5xo=;
        b=qLyLYWRVK5dZOjtSk5uV8pONgaFOR0NBQL9Rri6opJkI1ZWkSYUhhiZ1C3Zz3LvCjp
         Wc/+gh8/4z1OuTPYFvvbRJ1XhjU6xRyyEGkujsglulyYWzHuB/EcMCx/stACFGCIxh6X
         MCMIQMAdfKYGQDgV4CiDWLKAe2ClBSvyhYvWkhdg9rKOyasOukBWTNS3hlOdfTfHNuF5
         gthvP7dnhZmoBadvprs4eyxkx66kMZiJ+CTzhOpnrtky6egrdUDhVVe+9AoNJM0VF1hy
         Ehc/no/a3A2g14HIJpmForNkCw0DyFIUVAwozX62DfHmjdjo178x1EFYwL4pkDIiUzJi
         IjOA==
X-Gm-Message-State: AOJu0YzpsuqT9n0mEVQku6GorrIfegnuw1bvyQgWcXhRpMFpgq5I1072
	6AQ+ICsF/wf28on6JNXVlV5jYOXNIi9jnuU10sxjV9lp0yzYLYP3r0gInyUaM4E=
X-Google-Smtp-Source: AGHT+IGJujCOaBUh3+oOR5ApSS6lvEa3a0jxNEBbqxn0JlqDSpYkF/buTzCRYwtvZMYQKa3lmxc9mw==
X-Received: by 2002:a05:620a:268b:b0:785:9516:e18e with SMTP id c11-20020a05620a268b00b007859516e18emr2146194qkp.74.1707491419707;
        Fri, 09 Feb 2024 07:10:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVvDdCfhFiryxWiYoJ2gBpV2oU/ctUCfE12dXwi2MCN5uEKO+MzA6EyjHUcEdauLIMu/Dhu39NM91HuTSdFlFqTQs1uigFEsJ6VdHtifb1WG2boHZV++LMH5/2PlduQGZ3Xfo1GPPUtLjAu5SuBx104V6/YlQ1W90oJH4QK0wlM9/zB6kMw2p03qMVMgU5F06FYfv1e9g96JfriQzsgfAYpSyHC9t7+4u5JN4JhhSTVJ+LGFW3tye2eH8mqomknTNbUylun83aBCPrvRImIZojgO2ICF6CFEp7FGQODOLSI1Q8RY6oFzQXAhAniujYJyIhgxQcCMdtuFQeTgIyos4CO0NJ9Vvs/zc9BjxzWtjWcHlG1bOs/uFri+QsOP8IBcRsNtBnBLoLTAVb0eu97DUt80Vcr
Received: from nicolas-tpx395.localdomain ([2606:6d00:11:3354::7a9])
        by smtp.gmail.com with ESMTPSA id c6-20020a05620a0ce600b0078565ed2bc6sm790938qkj.124.2024.02.09.07.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 07:10:18 -0800 (PST)
Message-ID: <7322a22591ab18a664c9b6fa07957a163fceaa2d.camel@ndufresne.ca>
Subject: Re: [PATCH v2 1/2] media: v4l2-ctrls: add encoder maximum bitrate
 control
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Sachin Kumar Garg <quic_sachinku@quicinc.com>, hverkuil-cisco@xs4all.nl,
  Mauro Carvalho Chehab <mchehab@kernel.org>, Stanimir Varbanov
 <stanimir.k.varbanov@gmail.com>,  Vikash Garodia
 <quic_vgarodia@quicinc.com>, Andy Gross <agross@kernel.org>, Bjorn
 Andersson <andersson@kernel.org>,  Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Date: Fri, 09 Feb 2024 10:10:17 -0500
In-Reply-To: <20240130112400.2636143-2-quic_sachinku@quicinc.com>
References: <20240130112400.2636143-1-quic_sachinku@quicinc.com>
	 <20240130112400.2636143-2-quic_sachinku@quicinc.com>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Scahin,

Le mardi 30 janvier 2024 =C3=A0 16:53 +0530, Sachin Kumar Garg a =C3=A9crit=
=C2=A0:
> Introduce V4L2_MPEG_VIDEO_BITRATE_MODE_MBR rate control to
> limit the frame level maximum bit rate.
> Encoder will choose appropriate quantization parameter and
> do the smart bit allocation to set the frame maximum bitrate
> level as per the Bitrate value configured.
>=20
> Signed-off-by: Sachin Kumar Garg <quic_sachinku@quicinc.com>
> ---
>  Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 2 ++
>  drivers/media/v4l2-core/v4l2-ctrls-defs.c                 | 1 +
>  include/uapi/linux/v4l2-controls.h                        | 1 +
>  3 files changed, 4 insertions(+)
>=20
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/=
Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> index 2a165ae063fb..05ef4a70e3f5 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> @@ -576,6 +576,8 @@ enum v4l2_mpeg_video_bitrate_mode -
>        - Constant bitrate
>      * - ``V4L2_MPEG_VIDEO_BITRATE_MODE_CQ``
>        - Constant quality
> +    * - ``V4L2_MPEG_VIDEO_BITRATE_MODE_MBR``
> +      - Maximum bitrate

I'm afraid for this one your documentation is too short. I believe your com=
mit
message helps, but this is not what our uAPI users will read.

My understanding is that this feature is a form of constant quality (smart =
bit
allocation) but with a maximum rate guaranty. Using a specific mode (rather=
 then
a constraint on top of a constant quality mode) is a Qualcomm specific desi=
gn. I
think presets are generally easier to use, so I kind of like it. What is mi=
ssing
(arguably all these modes documentation are also missing it) is the rate
observation window. Would be nice to check if there is a way to specify tha=
t (or
even configure it, if so add a cross reference).

So I'd like to see some proper documentation for this one, remember that V4=
L2
documentation is also a specification and will serve to ensure drivers conf=
orms
to the preset expectations.

regards,
Nicolas

> =20
> =20
> =20
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4=
l2-core/v4l2-ctrls-defs.c
> index 8696eb1cdd61..e0597b61ffb9 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> @@ -154,6 +154,7 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
>  		"Variable Bitrate",
>  		"Constant Bitrate",
>  		"Constant Quality",
> +		"Maximum Bitrate",
>  		NULL
>  	};
>  	static const char * const mpeg_stream_type[] =3D {
> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2=
-controls.h
> index 99c3f5e99da7..7c74d6c417d1 100644
> --- a/include/uapi/linux/v4l2-controls.h
> +++ b/include/uapi/linux/v4l2-controls.h
> @@ -393,6 +393,7 @@ enum v4l2_mpeg_video_bitrate_mode {
>  	V4L2_MPEG_VIDEO_BITRATE_MODE_VBR =3D 0,
>  	V4L2_MPEG_VIDEO_BITRATE_MODE_CBR =3D 1,
>  	V4L2_MPEG_VIDEO_BITRATE_MODE_CQ  =3D 2,
> +	V4L2_MPEG_VIDEO_BITRATE_MODE_MBR =3D 3,
>  };
>  #define V4L2_CID_MPEG_VIDEO_BITRATE		(V4L2_CID_CODEC_BASE+207)
>  #define V4L2_CID_MPEG_VIDEO_BITRATE_PEAK	(V4L2_CID_CODEC_BASE+208)


