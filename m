Return-Path: <linux-kernel+bounces-100743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4487879C99
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11FFC1C21A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706A61428E9;
	Tue, 12 Mar 2024 20:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ElgnVr/3"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B785A1428E8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 20:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710274075; cv=none; b=Fgbnkai3qgCsUDDjb8ryOVCDpaAGn7FDTcCslEz9bdg0WOHHjVQLZ0TGel8tNIbZOz/hQTQ6x6Y+EPxktepO6HoWwvlGZWmizt5t9U1eIhx2ViYJLg5YOnXjYbIxoY2to7xh7RGROq6+dF1JdzaE97onsyLQ4xjGv51nW/PM5oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710274075; c=relaxed/simple;
	bh=KK3vfTC21FfD3a3vNi4VaniP6dAy7ashn5OtgY1y6Kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YzZ1pUW4XY5q8YeI7P7GvAMCXCs1/KrBVJt9eNv7K8oVV84Vh3MUbzji5ABkhSPPX8FBgOo/CPZ9SsH9oGgDYhbRFcHx1yby1StaRxM8wVaEcIiGf050Vfg6nS13uY4pHNJZUgxcCNSBHIYX+h5dFoMol7T8e1fDeZmeAAPXQM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ElgnVr/3; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso215450276.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 13:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710274073; x=1710878873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIM56byQCwYfF5RCflaFTltitkLV02ChrYWIQLMiS/Y=;
        b=ElgnVr/3Q/zYk3p8cOr0srbGrwrn6SR+lC77XKGviNYk3F5Pp4ywOeBM4MexCiFGAb
         K1JldP5PIG50cuVSCEjquhwrRdW1pHztVk5hQWrrQlPiOtHgMfw+F8fjjPybyawQHeKp
         ZxyNdr8MI26Bj1AiSGBU6JkWMAFkvga9MPrGDq5CS+FiSwhZqZZb1peNgdyHRwBj1kM4
         l9k3SECxSnTxmpzXoVifZzVrBdkUrGT+ZITUIt2GnyCZmREQM6Z7LYy6M4h0oHBRApMC
         rXXmCc+zVuhcVCRcZsSBg/JWhX033y01J5x2vyxo0NS5vyCVyEcK20CHIOiuT6OGvjes
         4Prg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710274073; x=1710878873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIM56byQCwYfF5RCflaFTltitkLV02ChrYWIQLMiS/Y=;
        b=fH3Eri/YfyD+itc/qfU/pqwgKPAC7n7gwVAJO21NZejvx0onpcXpEYFrcUYBzYTIce
         n/pzd9h0vWZJ1d9BYzT8XlT9QRnybeg6AYIQzaulCyJD1vQhVBPH8fjGtLYVStyoDOQ7
         fBXeCZoV2lb2+zNEYFX7jP8RmaEaSZGOr20WgUE6tA/RwVlI9H0zHRWc1FMT0zsXiZO5
         uHZfc0phhE78ZwjcNNNlY8mq/hM/MxS1fRozhQNXG7Bw6GcMwzYacl04UpkH9TKqgyU1
         Xkm1j2Dmr9NQo0a1P0QHF6C5fZWk493LKk2luTjANqOYAb2NUPh+RMwwXF3mnXJd9q3w
         u1FA==
X-Forwarded-Encrypted: i=1; AJvYcCW+K5KhAKLJhwm7p7SV+k3or4wB6Hm5K9/dqNTkAF6KOAlTP0wI9eiSaR/i1cmwHLpUFAjst1B7Z9IDJIaAkaKttIyktKuCjK+9QOHH
X-Gm-Message-State: AOJu0YyWwLDuBQdKIigjGYkSXUkiXisKbE4EVTb0TjDqfmINf5qUrX12
	yB7KSh0Qyc48GgYnmlU1wKhLNCqVgrbGjMlGiCcGKhAbCP+Xl4UkCDVJYR/SnqYuWMQq6ocrHyY
	Y/uHkI4PQbHWrIx4idIfv+66Y3rX/iZIAmYRM
X-Google-Smtp-Source: AGHT+IFUO9loFBNfYwY2rilDGi4a1ZxrFKhf7gDp1B59xt2uvInDy15QqH6xxud+73LelILqgfwJCkTcRwHNX1HB0r4=
X-Received: by 2002:a25:c714:0:b0:dcd:b806:7446 with SMTP id
 w20-20020a25c714000000b00dcdb8067446mr396824ybe.1.1710274072732; Tue, 12 Mar
 2024 13:07:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1709768084-22539-1-git-send-email-wufan@linux.microsoft.com>
 <1709768084-22539-16-git-send-email-wufan@linux.microsoft.com>
 <20240312025712.GE1182@sol.localdomain> <20240312030712.GF1182@sol.localdomain>
 <51810153-eb6e-40f7-b5d0-5f72c2f4ee9b@linux.microsoft.com>
 <568fae5e-a6d4-4832-a1a1-ac3f4f93d650@schaufler-ca.com> <746a5548-0e98-4953-9e71-16b881c63aa8@linux.microsoft.com>
In-Reply-To: <746a5548-0e98-4953-9e71-16b881c63aa8@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 12 Mar 2024 16:07:41 -0400
Message-ID: <CAHC9VhTYoT-XrSp4h5QwT5tnzBS6NHG0XSQ=cKLueM0iM0DvJw@mail.gmail.com>
Subject: Re: [RFC PATCH v14 15/19] fsverity: consume builtin signature via LSM hook
To: Fan Wu <wufan@linux.microsoft.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, Eric Biggers <ebiggers@kernel.org>, corbet@lwn.net, 
	zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, 
	axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, eparis@redhat.com, 
	linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Deven Bowers <deven.desai@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 3:08=E2=80=AFPM Fan Wu <wufan@linux.microsoft.com> =
wrote:
> We could also make security_inode_setsecurity() more generic instead of
> for xattr only, any suggestions?

For the sake of simplicity, since security_inode_setsecurity() doesn't
work, it probably makes more sense to create a new LSM hook rather
than make significant changes to security_inode_setsecurity().

I'm looking at the fsverity hook usage in this patch as well as the
device-mapper hook usage in 13/19 with security_bdev_setsecurity() and
I'm wondering if we could adopt a similar hook as we do with block
devices:

/* NOTE: these are just example values, more granularity would likely
be needed */
enum {
  LSM_INTGR_DIGEST,
  LSM_INTGR_SIG,
} lsm_intgr_type;

/**
 * security_inode_integrity() - Set the inode's integrity data
 * @inode: the inode
 * @integrity_type: type of integrity, e.g. hash digest, signature, etc.
 * @value: the integrity value
 * @value: size of the integrity value
 *
 * Register a verified integrity measurement of an inode with the LSM.
 *
 * Return: Returns 0 on success, negative values on failure.
 */
int security_inode_integrity(struct inode *inode,
                             enum lsm_intgr_type type,
                             const void *value, size_t size)

.. if the above makes sense, I'd probably adjust
security_bdev_setsecurity() both to have a similar name, e.g.
/inode/bdev/, as well as to take a lsm_intgr_type enum instead of the
character string ... unless we really need a character string for some
reason, in which case use a character string in both places.

--
paul-moore.com

