Return-Path: <linux-kernel+bounces-137581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8184489E43F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B330B1C227C9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9812158212;
	Tue,  9 Apr 2024 20:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PZtcfELs"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749041581F8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 20:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712693699; cv=none; b=O42BQHHZj8kzk19RQsW4MUQn089maBFV9fvjQgiJK2flM5VpRSGBaxO4sTl5d0a+PhldM9aFE9W1MrMnym7BLXl9+qsHwzzCHSS3oprs1YD5vxPg4A2D/AVMsgVAOd7N1cghWReH5bRuwqhNI2X7Cxay9Rk8lY1Q8jfxDEOnumw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712693699; c=relaxed/simple;
	bh=2SbgLvgPGkcDv0lCPd1iXo8d7o7QDk5hgPKEFcSWSls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CTDs1a2eGglfPtn5WENncj0jn/k2nKMUYwP21GmiibX1J++LkbSAUnwXUK+Ojndx+s8PRB2g5b9ne3qO0av5b527AGmQ4PTM5MUKe3cgs4Awr80CqbQcXTKaDbauDu20B3uotyeQ/Z5Tg1wVYCZL1dT+BjDxKUV9pcPDzn/8Mlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PZtcfELs; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dd14d8e7026so5627276276.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 13:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712693696; x=1713298496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0YVQ9djY2M33MWph8FPZMPtyUpc6ybsMtuQAt43J/Y=;
        b=PZtcfELsz3rwGgDJAZIoMllf//1Z6O7akXXFVcVivFc3oFY0oUs//r3yGCUL1jyLPe
         pi3Z628Cxz/kqdRFUZRa2QX9cSCgNVGe9wSQMLE/FYv1loD/asr64OhME59V8FzCuDqh
         UOV1QdeJcF1CI0/+UotCzIDkxGMTx6Difn+iSiFwAOxATq1J834JiWLUiSjcWWXayEBn
         Ymco/s4fIncJ5Yb5FDkdJ3ifL81/ldft5G/sqTvRfo8TpwhRz4FOsuFyZk4tA44StKzV
         sQpHSnCT7Jb5iZu2G70tvRBXBRdeB68OEiUXUnMuwatpPcs1GQCwd+9jNDhjmvgzVUah
         rn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712693696; x=1713298496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0YVQ9djY2M33MWph8FPZMPtyUpc6ybsMtuQAt43J/Y=;
        b=B5ZKSe2des1xBqEczWk1fK6RNjeem7Ma1GtucEy3SWHkUCyKj3pa8ZpqKFpn61CwL0
         yBsfSvPJ4pnZgxsKyv6UlbATpg89H9Fs2nBEfjlNsABtqqFIeBq3d93PKs3Neyb/VVxH
         4tULMb8YN8fZDP3G23VoLV2EPwYdwHXgl2Kylb57qtq5yICWR2gaieVQ9fDOqFJPiXw2
         yGzpYAgbKXGfiSmO0euZJzA3lIgwB73CC0jsvyJrPyZp1rWq93tzNcAMeP2rHdVGFjW2
         8Gsdt1o9CNSyoRhFIZdqdNH+wPp8kMC4THGrG4mQDWkNsR0lpf/PjAN8j20y4TL6caG/
         3j8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/cUYrxdoZMjDEHlUteWvkcH7or4slTC2y9UfPtrfCbn4gy5QF4YQ769CxNsmU3jMMCj58uyuhsolbh2URkHsxJlT7nPQZrBdMV8tW
X-Gm-Message-State: AOJu0Yzce/Uv+N5gfxJ6p3GYo9zgAYSLSzesx91gMZtXGCBQQtwS2HTC
	bBS7m1u7teJQ/qCLJxkCc31q6A+t6V1j3EmMOlFRzNfRGd7qZuFrewjT80vxq5dU3RvTpVOPr+1
	TodrZfTR2tJ8CVhycubutb9leDrgy/cLjbJP6lKf8eJAGVykS1A==
X-Google-Smtp-Source: AGHT+IHOHfb3Vsx0X6ltkSVRZFRT+zreJyCaHp4J4qYazQG9Rm3OCb+u4xunfbpGxaxtGsfS74W6Ks+5hyL3bJx9lHY=
X-Received: by 2002:a05:6902:100b:b0:dc7:423c:b8aa with SMTP id
 w11-20020a056902100b00b00dc7423cb8aamr1106734ybt.12.1712693696380; Tue, 09
 Apr 2024 13:14:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402141145.2685631-1-roberto.sassu@huaweicloud.com>
 <CAHk-=wgepVMJCYj9s7J50_Tpb5BWq9buBoF0J5HAa1xjet6B8A@mail.gmail.com>
 <CAHk-=wjjx3oZ55Uyaw9N_kboHdiScLkXAu05CmPF_p_UhQ-tbw@mail.gmail.com>
 <20240402210035.GI538574@ZenIV> <CAHC9VhSWiQQ3shgczkNr+xYX6G5PX+LgeP3bsMepnM_cp4Gd4g@mail.gmail.com>
 <87le5mxwry.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87le5mxwry.fsf@email.froward.int.ebiederm.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 9 Apr 2024 16:14:45 -0400
Message-ID: <CAHC9VhTF=-Sh6w4icTPA_=A25-EL55Nt-z=mvyb1-vONoN=5wg@mail.gmail.com>
Subject: Re: [GIT PULL] security changes for v6.9-rc3
To: linux-security-module@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, linux-integrity@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 1:38=E2=80=AFPM Eric W. Biederman <ebiederm@xmission=
com> wrote:
> Paul Moore <paul@paul-moore.com> writes:
>
> > I know it's everyone's favorite hobby to bash the LSM and LSM devs,
> > but it's important to note that we don't add hooks without working
> > with the associated subsystem devs to get approval.
>
> Hah!!!!
>
> > In the cases
> > where we don't get an explicit ACK, there is an on-list approval, or
> > several ignored on-list attempts over weeks/months/years.  We want to
> > be good neighbors.
>
> Hah!!!!
>
> You merged a LSM hook that is only good for breaking chrome's sandbox,
> over my expressed objections.  After I tested and verified that
> is what it does.
>
> I asked for testing. None was done.  It was claimed that no
> security sensitive code would ever fail to check and deal with
> all return codes, so no testing was necessary.  Then later a
> whole bunch of security sensitive code that didn't was found.
>
> The only redeeming grace has been that no-one ever actually uses
> that misbegotten security hook.
>
> P.S.  Sorry for this off topic rant but sheesh.   At least from
> my perspective you deserve plenty of bashing.

Just in case people are reading this email and don't recall the
security_create_user_ns() hook discussions from 2022, I would suggest
reading those old threads and drawing your own conclusions.  A lore
link is below:

https://lore.kernel.org/linux-security-module/?q=3Ds%3Asecurity_create_user=
_ns

--=20
paul-moore.com

