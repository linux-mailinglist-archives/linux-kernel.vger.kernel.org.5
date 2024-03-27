Return-Path: <linux-kernel+bounces-121812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A386B88EE04
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D581C33276
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6361F14F9DD;
	Wed, 27 Mar 2024 18:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RG9k/lHb"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5104314E2F9
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711563281; cv=none; b=Zg8l18QNfoPBR4qMG6UrOaoNDly8BdxK6+zl4B14Ecrg1hKuRJJYERU53iojRBZmUtfpdsS6WciogT0RSVLEEiWJLKnRO1GTpOKZ4I3ocyUx5vSr4DAZ2yln5y8aHLQlYfSxcvAMV3uwsIbjbiJh9bJv59zn+R2IDfSfPwV3Ypo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711563281; c=relaxed/simple;
	bh=c+HAs8na8S1a+bn6lSS66HuiZEpVDV+PpxLmevXlW20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pz8PX7B3HqXCaYcGYMqTTdx07LaVr1TZMzbrDYui0vIIqMP0VnDWJq9Qbzf40vA3b+I83MGeXJUJO4s5FTFhozG/HoZ4bENhUDPinxPsHyKjgUkNW5wFpGAOJUxZ8KBuC4AVqf9qf/SJW9F069K2ZQlAN6FNk2SL5C4rq7OTKg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RG9k/lHb; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29f819d1651so128530a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711563279; x=1712168079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+HAs8na8S1a+bn6lSS66HuiZEpVDV+PpxLmevXlW20=;
        b=RG9k/lHb93IxfU4M7Wd9U8opkkWNZF4hohkzXk4opZuVkx/zGXaqlBDyqwJokfv3F6
         AAiqHy0qT3VQHTEAfqJL9sTCFGQeqIrqT7zrj/Lj2aTUN7FgH2gQcmDcfrkqKMQe5tNU
         I/f839XVckO+19KbKDYC7zecDzo20mvHsLNI8BiAC4l+pT814kmj+oEwPWHxaLMWj1gt
         lm+IigusoOZBKM4vZO6CEpaxXNbOK5wZlmAcJrGIRF/h+JY5e0WOJ8UCpbTTOlSh9Fwy
         nBUSsbvJGmwwQ0JwxTPRFNRSHllXpCH41RcoucA33O9Y+z3cJAhvahhGJg90ZUJCMdhx
         2Rdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711563279; x=1712168079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+HAs8na8S1a+bn6lSS66HuiZEpVDV+PpxLmevXlW20=;
        b=QiHGNctL5MsIznkIt/U6XedbsspIx4XsCow4TtpoOL0wU0/nQ4OZGm6rXbJtWWBXC9
         OW04PZD5aLAP0IgMcpLawxqezmMAxy1FndsH3A186WGACujBOWMIelwKJsQNt6bC488S
         mnyldYc+v6TwY2X4Vnkvm8TcNUnhNHR40N8/09y234fEddWb2DPnaQGR0QVthQkrgmnI
         RUJ+oedMO3KD5wNjj521RrbRfSsB0wByp8cniTcFAydv2ekhGRfYQhJ0ZnMlkbEnxP7w
         AWQsyPjPZPSyvlhfoSCQ+RPPHaG2T49BQw0o2GnAavqb0oadqwii3wNrMYM5u6lstncG
         9T/A==
X-Forwarded-Encrypted: i=1; AJvYcCX9ij7kOWPtE0fYRQU8k07d0ybWQAC5MlKo7Ga3BcZPh/1OmEh/NOdFp3c0jOo1MWaLb//ZZoDF7UD+es0Uz4CjM/egACkz+ByDq0Wq
X-Gm-Message-State: AOJu0YxPCvmS8o3I3KP2LRHEGRh7sn1z4rsvFlp1f/ZIbLA0SDLbEitS
	hIOPzVcVjHFhZhXrKo7CEnDn8XEdO53s5U1Gm0znOg9OVzzEGtc9HVhMCj0QPcdrhruhKWI4zJV
	nTRoZWXU9abDI7KECs9S96QhBXqw=
X-Google-Smtp-Source: AGHT+IHnSIlLulq0AsyDt/9ly+HaxaRItPV6nqivKIU7J2Nb3KNQ0NWtBnqlPPqPhd9pV7pygYtLClxUydXGZyW5r/Y=
X-Received: by 2002:a17:90a:65cc:b0:29b:9a08:6007 with SMTP id
 i12-20020a17090a65cc00b0029b9a086007mr394616pjs.46.1711563279395; Wed, 27 Mar
 2024 11:14:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327175556.233126-1-ojeda@kernel.org>
In-Reply-To: <20240327175556.233126-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 27 Mar 2024 19:14:12 +0100
Message-ID: <CANiq72=kGWSQR7TgKDnAaef+FS3VGQeo3ri5vv1wxpW_88vdqA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/qxl: remove unused `count` variable from `qxl_surface_id_alloc()`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Alon Levy <alevy@redhat.com>, Frediano Ziglio <fziglio@redhat.com>, virtualization@lists.linux.dev, 
	spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>, 
	Colin Ian King <colin.i.king@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 6:56=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Closes: https://lore.kernel.org/lkml/CANiq72mjc5t4n25SQvYSrOEhxxpXYPZ4pPz=
neSJHEnc3qApu2Q@mail.gmail.com/

Should have a [1] at the end.

> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> Given there is a loop going on here, it would be good to double-check whe=
ther
> this variable was supposed to be used for something useful or if it was j=
ust a
> remnant of a version previous to v1.4.

Also, I see Nathan sent meanwhile a message about these two that were
also mentioned/reported a while ago [1].

On my side, I noticed these due to my loongarch64 defconfig
compile-test with Rust enabled yesterday [2], but I don't want to step
on Tom/Colin/Nathan/ClangBuiltLinux's work, so please feel free to do
with these patches as you will!

Thanks!

Cheers,
Miguel

[1] https://lore.kernel.org/all/20240327163331.GB1153323@dev-arch.thelio-39=
90X/
[2] https://lore.kernel.org/lkml/CANiq72mjc5t4n25SQvYSrOEhxxpXYPZ4pPzneSJHE=
nc3qApu2Q@mail.gmail.com/

