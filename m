Return-Path: <linux-kernel+bounces-40957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E220F83E8DA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 02:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3A66B224B4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9910F5390;
	Sat, 27 Jan 2024 01:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qzVb0lOj"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224CA33C7
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 01:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706317608; cv=none; b=Q5EnMyibF9n/ZQvn8cRLRN5+m+7Tw1XItFy5FBwK+7NTyGCt8/H435TtwiYQMZvQnh2RsoA3ABO+YAa21latGH1FEo6aGA3HyoZ1EBtcW3CsZlnzwYNZgeeZRMUzKeKz7Rx8jPO3+r4oqoF1bPjuof6WxF0i3QXGx5Q8aMqfS3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706317608; c=relaxed/simple;
	bh=rGwwMkSK1WXOlipgf2XPP6+z8z9uIudmopnVaL82miw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a7Ck8AmGj+jWGOkvzhE1ESjKHvFYX29SZidzfx+u2lo9fJw3jj5LkHuD0Pgod4PhNJ/zMaTRFlP9D/QcT+9PhF+ewWTmJgQJGIj+ZJUuhZAHtHHMUVwGu4I+PiauomQZ6/vB3MQxCVejlegx2IMcn7rLLl7LVQ48g2qO73WiMOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qzVb0lOj; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55c89dbef80so1698a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 17:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706317605; x=1706922405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lERtvALcvBmqHO5fFyK8msqLuBMgcfanDbIeCkihQ/Y=;
        b=qzVb0lOjWWPzZigIVLsf/4Tivun9XOEecyv0+jmkQPiorFPyNCgCXxG0fOhqN+XpWO
         e2/LNIXdCzHkP9JSJM42ouwa+hlHpS+EOfE6j3vv0SfV1crHddvN4oNZ59yIEistEjXP
         T1UdF7ItlAOGvU44b0y8NSlTDv0CRyn5+aoD9ZRbzSeamCu/QDW5rfS8x2ptb1G3t2c6
         pqciz6WJC3mI+m0qALGQJhUSEW2pRv66ZnRauHSVM9bp2tIS2ePo82gCgNuX6KcsjYsH
         DjmkC0HwJD/RY3l91B7tOWwfZsRWY6jNFFVWhHUinf4QovRQh5mbqT/V/fulQ7qk5R+C
         WL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706317605; x=1706922405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lERtvALcvBmqHO5fFyK8msqLuBMgcfanDbIeCkihQ/Y=;
        b=txjRgePh3YmGPVeEzTZVL+HZltdYUbuWSobk90oZWslslMvXJ3hzo3+AgkBPieWCwO
         WAwssSeOJMNI0+jVAw5VbtrCmB/xtfhVMwU3MJs5V1Mhs4138VHPYBgzpYSY7h/ualQA
         1yH6jmT7UAJ14O98FfXPWkdeo+f6uCpKSHzYXS7SHydCBmBv7AdhUxyY83plokxQBvpM
         jCPk6u+NMB1vaGOkASwVjFpyOX9d/KwCb+7N4GzRdIgniwYOzF+2uVbO2qZOJllkASU6
         hi4fg9K6Bc0Fy0aqem4zfvYtWbE5rAneUDXaeO2VMNYJ5if/kCopwEs5dnZ7rPWwH2yP
         tILg==
X-Gm-Message-State: AOJu0YyiOHADkezo68GEKIILr/258K65b2EkjP1d5/DTxcSjzq+476Ak
	bHgMM3rD5xRf4EaMYlChe2ER/LKq8ZmYNf7wPA9u+XyyBUeSEruvDKfWfJnTK8uIma6CJ/nigWn
	LmNqX4LiCDlpDOMy+UmRc/7XEPQBD+L2tUUvX
X-Google-Smtp-Source: AGHT+IFfl8okTj1sLPECag77wi9cpchm5gm+vHpLxNX6eWO2PkFLoI5pOSmFUP09Bk6OdpaoiSE1KK0M60Dw67idXsc=
X-Received: by 2002:a05:6402:231a:b0:55c:fe86:50f with SMTP id
 l26-20020a056402231a00b0055cfe86050fmr253407eda.5.1706317605002; Fri, 26 Jan
 2024 17:06:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706307364.git.thomas.lendacky@amd.com> <61316ac5a8217f0397da87c78c2db08580ad75a5.1706307364.git.thomas.lendacky@amd.com>
In-Reply-To: <61316ac5a8217f0397da87c78c2db08580ad75a5.1706307364.git.thomas.lendacky@amd.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Fri, 26 Jan 2024 17:06:29 -0800
Message-ID: <CAAH4kHZjqq5OTyTqhCGxeCSrgw==_FyLqqLOaWK3JxQytF=k7A@mail.gmail.com>
Subject: Re: [PATCH 08/11] x86/sev: Provide guest VMPL level to userspace
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Dan Williams <dan.j.williams@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 2:19=E2=80=AFPM Tom Lendacky <thomas.lendacky@amd.c=
om> wrote:
>
> Requesting an attestation report from userspace involves providing the
> VMPL level for the report. Currently any value from 0-3 is valid because
> Linux enforces running at VMPL0.
>
> When an SVSM is present, though, Linux will not be running at VMPL0 and
> only VMPL values starting at the VMPL level Linux is running at to 3 are
> valid. In order to allow userspace to determine the minimum VMPL value
> that can be supplied to an attestation report, create a sysfs entry that
> can be used to retrieve the current VMPL level of Linux.

Is this not the intended meaning of privlevel_floor in
/sys/kernel/config/tsm/report/$report0/privlevel_floor?

>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/kernel/sev.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 121a9bad86c9..9844c772099c 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -2479,3 +2479,40 @@ void __init snp_remap_svsm_ca(void)
>         /* Update the CAA to a proper kernel address */
>         boot_svsm_caa =3D &boot_svsm_ca_page;
>  }
> +
> +static ssize_t vmpl_show(struct kobject *kobj,
> +                        struct kobj_attribute *attr, char *buf)
> +{
> +       return sysfs_emit(buf, "%d\n", vmpl);
> +}
> +
> +static struct kobj_attribute vmpl_attr =3D __ATTR_RO(vmpl);
> +
> +static struct attribute *vmpl_attrs[] =3D {
> +       &vmpl_attr.attr,
> +       NULL
> +};
> +
> +static struct attribute_group sev_attr_group =3D {
> +       .attrs =3D vmpl_attrs,
> +};
> +
> +static int __init sev_sysfs_init(void)
> +{
> +       struct kobject *sev_kobj;
> +       int ret;
> +
> +       if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> +               return -ENODEV;
> +
> +       sev_kobj =3D kobject_create_and_add("sev", kernel_kobj);
> +       if (!sev_kobj)
> +               return -ENOMEM;
> +
> +       ret =3D sysfs_create_group(sev_kobj, &sev_attr_group);
> +       if (ret)
> +               kobject_put(sev_kobj);
> +
> +       return ret;
> +}
> +arch_initcall(sev_sysfs_init);
> --
> 2.42.0
>
>


--=20
-Dionna Glaze, PhD (she/her)

