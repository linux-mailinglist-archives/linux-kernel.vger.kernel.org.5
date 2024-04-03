Return-Path: <linux-kernel+bounces-130023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC47897353
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9780283F3D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D751D14A08F;
	Wed,  3 Apr 2024 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GMcWIfYr"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A599F148FE8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156586; cv=none; b=qOd4VhlBDDfOFiTj4xI0IWtZpwDGnOvQk5Km+50Awr+zoe8p9QOQG0VVKoU8QC5asoSyygxmyA/UbDacHeWKdX8oAYhU4S992dzGtNFFJr/z8Qxv2c9AM4qJMM2hn4ysLgJx7c/THyx8Ov6AYmktTI2OlI2yz9KJR7Pod4SEmZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156586; c=relaxed/simple;
	bh=a7mNqaALJyPq3YdKVXicKQwMMqVLcFYOt4aFmY79KZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WHw9ZFAJNp45wf0AJnDOaL8Sor+eCcT/9CYRUwI8rDSSvV8PnG3AsT7y+X4CWkyQSoaFivKnWacNuJZxtbV2sQXETqeN/GEixieGI5CRPC4VgyocsKS/ZdPp6H2gX0mDLeeHmObuF/x5uKFBdHqn3BMey/RCRWTKLiNtN/4Zso4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GMcWIfYr; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc742543119so6354346276.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 08:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712156584; x=1712761384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oB/QZCIJNsw+4xmf5zobnrRWsDWTsJXOON4ReH8dtVg=;
        b=GMcWIfYrscgAst0DD1198oNQcsFMfoJUezrKRuFuSkBeRfUlhe12r/FugLlhXrhjeu
         kVcDqPEqIJjtPihBsbmlxgtpqxFdeAS8D2EFqLTdvi+V/MTKMlJFWDTV+NxXb3Urstno
         uHlDgkqMs9Py7j+iWmqbI7uTWyplzVeREnbJSH/hzqEUBusyomTt1uikCuT7VIIC2d1J
         ZCOhc352kmpbiZNf+/IPd5HgyMPOcDEEBP5Ki7v8Y8I4K8j8jgs25mAVXv6c34bMHG31
         D8MOcddtf/gRfQB4MxTLnLUarjmPwHenM+wRP/AlZk1tMTTjjU6rrOrdnN3EQr7ZMfpD
         Y9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712156584; x=1712761384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oB/QZCIJNsw+4xmf5zobnrRWsDWTsJXOON4ReH8dtVg=;
        b=UmYHZ9bFkGlZGlWjYncs9Fo/wrwmNHmDaVSs0xWN2/DLZjCDr7Kovwm3ZtcUwZrr2g
         JjOoDQSDL5ZU1Ylo1PaRxd302X/0ci+4KlWlLDDe+FcN8KZdYyflYdlULuqVg1wNjzDc
         Zk+XWxZgnC7ssVG+D5SlQUMyaEnwzRmuIvWOza5WyrgnYTp0egj+kQFTR4xwJ8O5+iDq
         XI707rOnmhMFD1b7KI4gUMndUGXAT92DYAmomo8TsbvBSstOYMCY+c91zz1TsiwKpUmy
         LsSjGtLdXud+cAtFQNTn591cAv8e6ntvmgwyiQTnNnhnun64CI45XF4t1rBz8SdA1eiz
         Nw7w==
X-Forwarded-Encrypted: i=1; AJvYcCXDuJyabgZWJhzjD2P2jQmb3O9CMr12sMfiWukDLxvC2tuIZJbqbagXBiHlP2QnpCUgLlBUVnWUqES+HJDqulQpHUYcTCo1xPfCrLpc
X-Gm-Message-State: AOJu0Yyf9nE17YZ2PRZ7X/7QB/0zDKCVOYPza8n6QVrCDpmcLwjBb4NA
	V0S7nxYghVLV9c2xFt5YAE/fE5C9yrdVjG25XF2XcyivbBLKFQ5QVpLCxH/06Pw7cq0+f0g/pVN
	ED/Uf2XXLI1s0BLS3tBDe3bQz3ukvWNFCkWLg
X-Google-Smtp-Source: AGHT+IFT4d6bpRvDAVa07rux2sG1s5ZKLWz6hKyaoKXTEtvPIEVh93oEV7NIJATmjfw8W0YvP4+xkMNiV5GnCLoztN0=
X-Received: by 2002:a05:6902:2b87:b0:dca:c369:fac8 with SMTP id
 fj7-20020a0569022b8700b00dcac369fac8mr3635102ybb.1.1712156583732; Wed, 03 Apr
 2024 08:03:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403090749.2929667-1-roberto.sassu@huaweicloud.com> <6d3b9d8a5f5a2ca010a5a701d7826e47912fec89.camel@linux.ibm.com>
In-Reply-To: <6d3b9d8a5f5a2ca010a5a701d7826e47912fec89.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Apr 2024 11:02:53 -0400
Message-ID: <CAHC9VhQjcvRBo30Y346p5Tbo3pspxnnmrLj6nvv1g=e_52SQUg@mail.gmail.com>
Subject: Re: [RESEND][PATCH v3] security: Place security_path_post_mknod()
 where the original IMA call was
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, jmorris@namei.org, serge@hallyn.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-integrity@vger.kernel.org, pc@manguebit.com, 
	torvalds@linux-foundation.org, Roberto Sassu <roberto.sassu@huawei.com>, 
	Steve French <smfrench@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 9:11=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wro=
te:
> On Wed, 2024-04-03 at 11:07 +0200, Roberto Sassu wrote:
> >
> > However, as reported by VFS maintainers, successful mknod operation doe=
s
> > not mean that the dentry always has an inode attached to it (for exampl=
e,
> > not for FIFOs on a SAMBA mount).
> >
> > If that condition happens, the kernel crashes when
> > security_path_post_mknod() attempts to verify if the inode associated t=
o
> > the dentry is private.
>
> This is an example of why making the LSM hook more generic than needed di=
dn't
> work.  Based on the discussion there is no valid reason for making the ho=
ok more
> generic.

I agree, I think we all do, but I don't think we want to get into
process discussions in the patch description.  The description
explains the original motivation for the buggy commit, the problem it
caused, and the solution; that's enough IMHO.

--=20
paul-moore.com

