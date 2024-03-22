Return-Path: <linux-kernel+bounces-111762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 893E0887096
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5091C22F0A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8B55FDD4;
	Fri, 22 Mar 2024 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFsTfxU4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDDE5FDD1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123865; cv=none; b=YFFSOSr71jTpUmG7tJapbwOtn29J606WFLKFqw2D31P9cLa4P8L2p/GV7dIVMyUSxqbfWDt4R1tT4VDPNnLdG1ODVyDGwZAD3XryhLQAOG/9q2K9i4wLZX+q568JFUMw0snU7IBCCPL5oEpwCOKITfBeqNzdTgPbhKHNI6jYPrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123865; c=relaxed/simple;
	bh=xxj9zaTdMixI9nA1mtjdnxIiUQAMmBn3Nsr3nDit/zY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQSpxG6klcQhqph1WPJTZ05a5WfFKP+MU1mlKLC13FAzWXO6+OR39+EgZRjyL0sTqwvnyqgjYhkbs0M8i75ySHEWIYFqJURgX4uAbCz/3VI2yX7n7DmoCj6MPpvN9HEeAg7G22x9yQ8y3mmCO8R6EZ4dfvZwgAlF93te/5jt6P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFsTfxU4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D559C433B1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711123865;
	bh=xxj9zaTdMixI9nA1mtjdnxIiUQAMmBn3Nsr3nDit/zY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BFsTfxU4+1Ym8UVTWxfWsZIoYEqTj6qj8qTfuwyf9RImj7J44WjqZQgBlDEqP+jcy
	 3pEYzLS+G8b1g3HvVhPqeCmDqjf3/YTEW8OztuQ7LmIC2w6Nn8VuF4vhp4go2HfH6/
	 dPZk/DWrgS5Sr8LvrWLDieF+8DaxlGoGiHAeqIe+IuB8Nbys3Vqy5EvPIwVMZtkv17
	 MMsSMwnMolQZ8+t0WSFLFjr1UpsAuVMfhaXA7h42kqzt+ogRHQmdtsoa1aNdQ23l6K
	 B2WbSMDDkkUGdrPbffOAL4d6pgP9stMN2mODlwhcSO8sio/F70gK40FaJeEiblBbFp
	 zvGHzq4TJpgZw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513d23be0b6so2770559e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:11:04 -0700 (PDT)
X-Gm-Message-State: AOJu0YxU9wGAxwqWWKkBipDzChggtt3ke7M/qN3t3Lp1vEpZ61t9m8Pe
	pu31lpyUnhRJHOaO+VGa7kovu5rFILybmnYdy6m/KOu+UF7G2fwOF7CgXymDvdfUBodN5y4ft8/
	5GRCuhPA8be5NjOvxjrcNhKC1sPk=
X-Google-Smtp-Source: AGHT+IG1v3vi0D/t9FfDpaFkNNuDWxvkQ5q1qbTnJSWVLI0ivkEfNGweInNXcb9hjpvNvQDSI7Y1QulD7yevjOvZvuU=
X-Received: by 2002:a19:7616:0:b0:515:973b:746 with SMTP id
 c22-20020a197616000000b00515973b0746mr1884638lff.16.1711123863371; Fri, 22
 Mar 2024 09:11:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711122067.git.thomas.lendacky@amd.com>
In-Reply-To: <cover.1711122067.git.thomas.lendacky@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 22 Mar 2024 18:10:52 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGUZAzBQMzZOsZaYuaGfAn4AHv1FMzZT9vvHCU3aAjcfg@mail.gmail.com>
Message-ID: <CAMj1kXGUZAzBQMzZOsZaYuaGfAn4AHv1FMzZT9vvHCU3aAjcfg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fixes for recent x86/boot rip-relative addressing changes
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Mar 2024 at 17:41, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> This patch series provides fixes for the recent x86/boot rip-relative
> addressing changes that causes system crashes when booting with 5-level
> pagetables and SME active.
>
> I thought I had tested 5-level paging with SME, but must have missed
> it. There are two patches to fix the issues that can be squashed into
> a single patch with multiple Fixes: tags if desired.
>

Perhaps you tested the entire series, where the final patch removed
those variables altogether?

> The second patch is sort of a revert, but instead uses the newer
> RIP_REL_REF() macro instead of reverting the fix and continuing to use
> the fixup_pointer() support.
>

Thanks for fixing this.

Series

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

