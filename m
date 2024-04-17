Return-Path: <linux-kernel+bounces-148833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C24B48A87E2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FB4D287CD3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218C41482E3;
	Wed, 17 Apr 2024 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbkUZ1SS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD89146D58
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713368280; cv=none; b=mC6WNxwJJJLB7zZ9RUNoq0xizohF/Dg5Xuc2TImynaq5UyMLGsoH7y2mphmn7niZuc6DFYLAnUWGuNriltCQbhBFRscrAQWbhxxBbp8SfpggWh+bgjkIoKLabPFpGlaKVG8hG/8zG9xkDMcoPLbWor3Vy+Ya2WGsILoez+tF5+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713368280; c=relaxed/simple;
	bh=mh2+5wpHchabfjbCTzG60AEhghAUqGqsxHVVQfQv3e8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jep5ojJY0W/2pgb6y621PbDu6qjm64tTtlbgR3pYUYYxBEHPl9zOl2TwkfJwYQEuBkzDZZ8hiRqUOfpP0FTJu6KVKfkYanlnfSdq26Wgqqf5IHmgGOXmK/vYNTecnFgIFXG1jYRZ5efgxRY3vqBGiFcDS7H1GM+1OgzGKO9uWUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbkUZ1SS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC56C072AA;
	Wed, 17 Apr 2024 15:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713368279;
	bh=mh2+5wpHchabfjbCTzG60AEhghAUqGqsxHVVQfQv3e8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=mbkUZ1SS5u1kbyTwSgUOP9zj+xdYEzY/cTAOi0OJ1TkcG0MlHdReTLJSp7mVWQFWc
	 Vp2khz55PEh0uWXJV5vpI5kW9IY8zjQSY7M8onw5UhB2Uo12JIOWHCe/I0vwXIFtAw
	 0ttP+cyFVHPQ8kw00TKum3NX1J236sK0myUoxCWELqjxZHBoDthG7mjIRdsSXXwNqq
	 u5cLPKqo6iSxgH2n1shXWYS8F0KwbAppqJR1FhDXygWCqTw5axbbCjcerQmqRxAI1U
	 AE0EfhmaXbu5Fv0l3o/mOONbRK231SLmVKOqDqB+pyAqKrTZqZJCJ0og5q0gTvk0Vy
	 eFR7Jd1bnDabA==
From: Pratyush Yadav <pratyush@kernel.org>
To: "Michael Walle" <mwalle@kernel.org>
Cc: "Pratyush Yadav" <pratyush@kernel.org>,  "Tudor Ambarus"
 <tudor.ambarus@linaro.org>,  "Miquel Raynal" <miquel.raynal@bootlin.com>,
  "Richard Weinberger" <richard@nod.at>,  "Vignesh Raghavendra"
 <vigneshr@ti.com>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v1 3/6] mtd: spi-nor: get rid of SPI_NOR_NO_FR
In-Reply-To: <D0MH78KYG87L.ETRH24X6MK6X@kernel.org> (Michael Walle's message
	of "Wed, 17 Apr 2024 16:43:15 +0200")
References: <20240412134405.381832-1-mwalle@kernel.org>
	<20240412134405.381832-4-mwalle@kernel.org>
	<mafs0sezk6rcr.fsf@kernel.org> <D0MH78KYG87L.ETRH24X6MK6X@kernel.org>
Date: Wed, 17 Apr 2024 17:37:57 +0200
Message-ID: <mafs0frvk6luy.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Apr 17 2024, Michael Walle wrote:

> Hi,
>
> On Wed Apr 17, 2024 at 3:39 PM CEST, Pratyush Yadav wrote:
>> On Fri, Apr 12 2024, Michael Walle wrote:
>>
>> > The evervision FRAM devices are the only user of the NO_FR flag. Drop
>> > the global flag and instead use a manufacturer fixup for the evervision
>> > flashes to drop the fast read support.
>> >
>> > Signed-off-by: Michael Walle <mwalle@kernel.org>
>> > ---
>> > Please note, that the fast read opcode will still be set in
>> > spi_nor_init_default_params(), but the selection of the read opcodes
>> > just depends on the mask.
>>
>> Since that is the case now, might as well drop the
>>
>>     if (params->hwcaps.mask & SNOR_HWCAPS_READ_FAST)
>>
>> in spi_nor_init_default_params().
>
> I want to address that in another patch where I'll do that for all
> the opcodes. Just doing it for the fast read looks odd.

Okay.

[...]
>> > diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
>> > index 072c69b0d06c..9aa7d6399c8a 100644
>> > --- a/drivers/mtd/spi-nor/core.h
>> > +++ b/drivers/mtd/spi-nor/core.h
>> > @@ -479,7 +479,6 @@ struct spi_nor_id {
>> >   *                            Usually these will power-up in a write-protected
>> >   *                            state.
>> >   *   SPI_NOR_NO_ERASE:        no erase command needed.
>> > - *   SPI_NOR_NO_FR:           can't do fastread.
>> >   *   SPI_NOR_QUAD_PP:         flash supports Quad Input Page Program.
>> >   *   SPI_NOR_RWW:             flash supports reads while write.
>> >   *
>> > @@ -528,7 +527,6 @@ struct flash_info {
>> >  #define SPI_NOR_BP3_SR_BIT6		BIT(4)
>> >  #define SPI_NOR_SWP_IS_VOLATILE		BIT(5)
>> >  #define SPI_NOR_NO_ERASE		BIT(6)
>> > -#define SPI_NOR_NO_FR			BIT(7)
>> >  #define SPI_NOR_QUAD_PP			BIT(8)
>> >  #define SPI_NOR_RWW			BIT(9)
>>
>> Move the other bits up since the slot is now free.
>
> Mhh can't decide what's better here. On one hand I'd really like to
> avoid too much code churn because it's already hard enough to follow
> the development using git blame. OTOH, a new flag would need to be
> added in between the existing flags. Not sure.. Or we if we run out
> of free spots at the end we might get rid of the free slots.

Filling this slot with the new deprecated flag should do the trick then.

BTW, -M and -C options for git-blame can help you a bit. They can detect
moved and copied lines, and look for the original one to blame. From man
git-blame:

        -M[<num>]
           Detect moved or copied lines within a file. When a commit
           moves or copies a block of lines (e.g. the original file has
           A and then B, and the commit changes it to B and then A), the
           traditional blame algorithm notices only half of the movement
           and typically blames the lines that were moved up (i.e. B) to
           the parent and assigns blame to the lines that were moved
           down (i.e. A) to the child commit. With this option, both
           groups of lines are blamed on the parent by running extra
           passes of inspection.

           <num> is optional but it is the lower bound on the number of
           alphanumeric characters that Git must detect as
           moving/copying within a file for it to associate those lines
           with the parent commit. The default value is 20.

       -C[<num>]
           In addition to -M, detect lines moved or copied from other
           files that were modified in the same commit. This is useful
           when you reorganize your program and move code around across
           files. When this option is given twice, the command
           additionally looks for copies from other files in the commit
           that creates the file. When this option is given three times,
           the command additionally looks for copies from other files in
           any commit.

           <num> is optional but it is the lower bound on the number of
           alphanumeric characters that Git must detect as
           moving/copying between files for it to associate those lines
           with the parent commit. And the default value is 40. If there
           are more than one -C options given, the <num> argument of the
           last -C will take effect.

[...]

-- 
Regards,
Pratyush Yadav

