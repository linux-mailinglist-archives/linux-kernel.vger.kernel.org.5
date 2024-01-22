Return-Path: <linux-kernel+bounces-33094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 529AD83646B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 803821C22A70
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417FC3CF71;
	Mon, 22 Jan 2024 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECz3VvnE"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6130D3CF5A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705929961; cv=none; b=LAS9LmL/K5eSUdlncXhmbrzcSjpNenTC+nAq3YM+KWPfFWJ3iRt2+szok+lqUt0fLDMsLPX8EzSWZr3dAhlDIDXYlKAaYpEyPLH6EycT/I4gqh6F88uKW07vKoVEKj86PK6eAiavAWSS9veBxuznyormYYAHEtQNJvOtMqmELAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705929961; c=relaxed/simple;
	bh=+IY+tfOH7zJnbjGk7hYlS29OqszFz0vs9oLxHBldGNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GWbaD6bf0YpCTI2VAls4B8u09EmDIBgmlNuvr0uy1jYsgfU/MJEndHpVcnzgmXM1Q83qma+/Ph2gNuTYVuLP4Tx2P5MH4dAQcA/V8qaCB88d1GO/b4gc++p8xDwhxvTO9zYvu+dXShwC7hZnDsWJGnbVuynR9GXbT6K8Q9HSAzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECz3VvnE; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc226dca91aso2697895276.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 05:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705929959; x=1706534759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2EXpV6xqoHqJuzPm5cEvHDlaObu5qMOKhYaowDZaLs=;
        b=ECz3VvnEFxZWi7u6JxnRrjgfgD77kISD11ctjP9lTLNK3r6he8SPOSyyM40dVlLFMg
         SD3cn2JBRv7zxaD/BUp6U8SBwbqx+Q18DTE6VEKX2P54a327RsEiq0mQc0mOhKuAeFd7
         ZuxpXo9lxxFulpXZHoDiynHqQ4m5+UaRyRk8PlasGixOTLUWe7P/L701/bDM2P+dUIvB
         viw/bavkcUIR9ZjOsGFyAl9H2LJdxSBdSfuhmhHmuR2j0exG42JN6Kx5aehdOZt5t7mM
         sPjLjgfxTUNivrPlWnElsPuWQ7QxfjDVRUb5A0Tv7srQv2Pv16RfvAdXMqZvdoB5PRgS
         JvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705929959; x=1706534759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2EXpV6xqoHqJuzPm5cEvHDlaObu5qMOKhYaowDZaLs=;
        b=qQddVL2fxVeubMMIvcEGlQv1cYNmj7DQmFr4E4j1VAzryiWq4Gwhau4uQLOPJkBrqH
         uZje/d6e7O9AJ6ATShTzekC57EBvZ4bgsxYmmOs1ByF0CF085HsevHl3Dx51mvNw1wsz
         o6Ai1QMKJfPUEO3664Jf9FHNWA51fCLU3c6f3XewIroC6f6vOe4a17+ZAOJIsOfOqv/r
         aI9CriWdar4Rs6khGw8hlOM1FfUMnQEbLxubrZ/bSMjre/86TTGHFaAsUPYghBRk5Zt2
         cDEDx5pdSUQAPs1Otc+3tqR8reETo3ZxVv/BJZJkn9iefnSxitEwvX1bBxItMTZ/K8li
         iyMg==
X-Gm-Message-State: AOJu0YxtUEGxnjDnelLAXozmDtenp+sVwpcUMyHJOg/YlCKDGAiyiLsI
	RtJZQO8nFOY4ZkT5iVMAUtGgDCbRZMWuLD0Hwk624xVNuT4h/CTeofy+JBtHx55xhExjYcLR7bI
	tNbqiTC+e9mAf5ma3rvETeRIvQqY=
X-Google-Smtp-Source: AGHT+IGooEEMFTIvajOh5dXtBxmZl5Gi4scxX5Kl9/CvfMVnSMv/V8qW15MvHBhhCBGQMMHipIZyGAKUnxKkxBF7UuU=
X-Received: by 2002:a05:6902:2587:b0:dc2:3411:aa4 with SMTP id
 du7-20020a056902258700b00dc234110aa4mr2107163ybb.77.1705929959276; Mon, 22
 Jan 2024 05:25:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Za5qb8livKA4XTeG@pop-os> <20240122132057.GAZa5ruRCBJzuuVKC9@fat_crate.local>
In-Reply-To: <20240122132057.GAZa5ruRCBJzuuVKC9@fat_crate.local>
From: Pranav Athreya <pranavsubbu@gmail.com>
Date: Mon, 22 Jan 2024 18:55:48 +0530
Message-ID: <CAP1Lp8_y+p+EZFhHvX7b1L+FpxRdXqit_2BZqGzYBvzVS8ojjg@mail.gmail.com>
Subject: Re: [PATCH] x86/alternatives: Fix switch block in apply_reloc()
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 6:51=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
> It is more compact and faster readable this way. Do not always take what
> checkpatch tells you to the letter.

Understood. Thank you for the feedback, Boris.

Regards,
    Pranav

