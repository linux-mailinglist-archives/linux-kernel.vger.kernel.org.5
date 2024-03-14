Return-Path: <linux-kernel+bounces-103133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C57887BB6C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DF591F216B3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FF95D73C;
	Thu, 14 Mar 2024 10:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STny6/aL"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B8F1A38FC;
	Thu, 14 Mar 2024 10:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710412673; cv=none; b=ZAAeDC2jC0eBETaA/pCXKNdqrHvSqfapIN1f/LdSUT9OiA4yb+bTwEETff5RqFOp0mOmbjgHh1rgaNU08nXCay4ResCoKwxUNr39lSDyxe2kiUGdjk+oobNufrSMUPS7itBJcR6ug+fVOdjGcDmBK8wReibyqHmpI9qO/xhXTxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710412673; c=relaxed/simple;
	bh=vzCmVzgk1A2WbwK3W/30teVzlmAUHDmYtHZ6Lsqwgus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ngl/mKJ8mlCS0ar4AEMaJ2j7hOMe2/71GMoLhJvpBLEremgcGFp33kQNlDHEohbzv672QgNpKOk/4jk5fm3jGZjLFNAWx8tmKZvsy9GrxxOMC/pF0uVgON7TvPsuPV2/mV7b98X3nyS/xuOfCiM/QtitJNydUQDgdBryo+9EBNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STny6/aL; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a44f2d894b7so75867566b.1;
        Thu, 14 Mar 2024 03:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710412670; x=1711017470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzCmVzgk1A2WbwK3W/30teVzlmAUHDmYtHZ6Lsqwgus=;
        b=STny6/aLVovMkFh8CXRIQiuhDHZXeqT5mWtcEljggGUSCWlerOfF3Jbg9a6K5dBJKE
         OYpYCrip3uTNFiDCzdWgiXN3sQ4n9RVfHgdB7XC7Yn/VNIxj58s2smG48+x3R7KEA/LA
         5RW0AD9L0CaiqP1TOWijbCtCqkpW9ty24EHiaS6c62jOp+zeyeynUMM9x8ksOK14qu6Q
         5b/7BUv7a4aYg179YBHWErA8MoJwbLoSf8KLFaWZx/eosSotLPaV+kq20Jc8X3JiFD0z
         OvYZibli2HWJLx7A0US3bLSiCeOLkLrUXvaHDfK2PeMMdBDfWjt+rzyDPjx/ArGa/74J
         mGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710412670; x=1711017470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzCmVzgk1A2WbwK3W/30teVzlmAUHDmYtHZ6Lsqwgus=;
        b=mziI605Gc/bQH8+2iKmfle3P85Q/h1tSAP8ZWiUf7PHE/FvXDlJxtJKtpymSzc6yno
         i5PvS6uTPMPt8dmhXI5OF6XhANFDaMjIuR7QcwqFETHHZfKE7uPNOhEhnHCk0oQz0i2J
         jBG1iBFwf2PtZz5cKCZAAqsPP+2h3sus9Y2URbiMV4WhbCTAaPtzxL0Lp/+9qi5/JSyN
         0evwPGmNpLFyProOcTTIfcP6l9EZEPh+9I8aGxHTPwW2JokX2BfD/ELWNDbwmbqvXM2V
         hnZUBfvuxTmX8hfJXiuOuWbMp3Up6oTvzjyAW3YtB2nFJ8CHAuuTP/F0KhywugDaAvQV
         wHew==
X-Forwarded-Encrypted: i=1; AJvYcCWyXIysNQqRwMm6YXCqBTuE/dDKllHPJ7MFMcWtYZswC/BaQkCFME4yk36HL7bH7DHdjM0nGA6LDJNArkt91YyFvi22QPchymQ/JdNf0NlIRBvb1lPUf/d5N3SrRPkPfoQKRoKg7fFdjA==
X-Gm-Message-State: AOJu0Yw1SoQ1DWsFqYCTpqxdx0DBZ1X+watcIcODx2t5/FiQ4SKSKqIM
	kk0bBEN4S5hSIhYj/UKVl/+9scGXRj0MWZiIj1SRy0UKHzvEdiCt1y4jPojpre+BnyeWo5HJ1r1
	I0WBxQBQy8/bANxPlrsrL6QL1DGg=
X-Google-Smtp-Source: AGHT+IHAgDyqVH7oGwixukT7CSGFbdDnW4TvuHEXAOyVQ/qRpBYbBxUZXwiLPNDdK50Y8a0SeFDblV5Sbfrs/AuuR+0=
X-Received: by 2002:a17:906:5801:b0:a46:614f:f2be with SMTP id
 m1-20020a170906580100b00a46614ff2bemr899128ejq.28.1710412670199; Thu, 14 Mar
 2024 03:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314084531.1935545-1-gnstark@salutedevices.com>
In-Reply-To: <20240314084531.1935545-1-gnstark@salutedevices.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 14 Mar 2024 12:37:13 +0200
Message-ID: <CAHp75VdM9GkogkeffY+0rwU3r2iWeTZ8-aj901MLteUmRfcLOA@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] devm_led_classdev_register() usage problem
To: George Stark <gnstark@salutedevices.com>
Cc: pavel@ucw.cz, lee@kernel.org, vadimp@nvidia.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, christophe.leroy@csgroup.eu, hdegoede@redhat.com, 
	mazziesaccount@gmail.com, peterz@infradead.org, mingo@redhat.com, 
	will@kernel.org, longman@redhat.com, boqun.feng@gmail.com, 
	nikitos.tr@gmail.com, marek.behun@nic.cz, kabel@kernel.org, 
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kernel@salutedevices.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 10:46=E2=80=AFAM George Stark <gnstark@salutedevice=
s.com> wrote:
>
> This patch series fixes the problem of devm_led_classdev_register misusin=
g.
>
> The basic problem is described in [1]. Shortly when devm_led_classdev_reg=
ister()
> is used then led_classdev_unregister() called after driver's remove() cal=
lback.
> led_classdev_unregister() calls driver's brightness_set callback and that=
 callback
> may use resources which were destroyed already in driver's remove().
>
> After discussion with maintainers [2] [3] we decided:
> 1) don't touch led subsytem core code and don't remove led_set_brightness=
() from it

subsystem

> but fix drivers
> 2) don't use devm_led_classdev_unregister
>
> So the solution is to use devm wrappers for all resources
> driver's brightness_set() depends on. And introduce dedicated devm wrappe=
r
> for mutex as it's often used resource.

The leds related changes (except the last one) LGTM, hence FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
(for patches 2-8)

> [1] https://lore.kernel.org/lkml/8704539b-ed3b-44e6-aa82-586e2f895e2b@sal=
utedevices.com/T/
> [2] https://lore.kernel.org/lkml/8704539b-ed3b-44e6-aa82-586e2f895e2b@sal=
utedevices.com/T/#mc132b9b350fa51931b4fcfe14705d9f06e91421f
> [3] https://lore.kernel.org/lkml/8704539b-ed3b-44e6-aa82-586e2f895e2b@sal=
utedevices.com/T/#mdbf572a85c33f869a553caf986b6228bb65c8383

--=20
With Best Regards,
Andy Shevchenko

