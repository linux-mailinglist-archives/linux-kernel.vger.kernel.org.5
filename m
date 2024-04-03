Return-Path: <linux-kernel+bounces-130531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7F089797A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886FA1C25C88
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419701553BE;
	Wed,  3 Apr 2024 20:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UEbf2sIU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA13154BF0
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 20:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712174565; cv=none; b=iKbnNFRbg8P5ayoNZ1K2teB5iApXaY0bnjLT3fkgeGhhEOm0fI0+8xEbWW3H3WjXCuLDLv7P4hy5GUbpzIFe0TDADNASHA9w/+mvL16Cuj8Z2N2Pn2zKabui81CQmORdATlsVFToSAqjnURHpQBGFCFnOonyG8X7dw5yceGTSRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712174565; c=relaxed/simple;
	bh=0N2x3C6WDeI9KM8YcO0XILyMudYclyFsPiGhmS+45js=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NPgfMoOz0rJUVYRFKM0OiWAsjDMDYsoUCUgnLE+SkRlkBBXbR1yzUG3s70cuOKGOCNYhqS0m9jGSOL8K1iE9qfjny6vI3ZSllDldBoEbkHXtBbRjdVhikS5Zbk9DO5Y/1TJl9H2GGlI1XvdO8zKabUvGL82KAi0JeHhCqB7Oz9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UEbf2sIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B787C433C7;
	Wed,  3 Apr 2024 20:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712174564;
	bh=0N2x3C6WDeI9KM8YcO0XILyMudYclyFsPiGhmS+45js=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UEbf2sIUxGoMiRP8asBi48y08rGiOihlyMCQPVzK29GBOy3V1lRWW+kXxyfRcA0hU
	 5bFDtYJ0tYD8YNcM72HNZ1p3MqS/yZN3Tz6R+LvZhpxQYzuDfWswTSnoqyj766hHhk
	 nsUgbLhDSwvsp8UaaVZIQUynoCnw/dnoHZW6CjHE=
Date: Wed, 3 Apr 2024 13:02:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] kgdb: Handle HAS_IOPORT dependencies
Message-Id: <20240403130243.41a65a767f03fd7c4d8dabf8@linux-foundation.org>
In-Reply-To: <20240403132547.762429-1-schnelle@linux.ibm.com>
References: <20240403132547.762429-1-schnelle@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Apr 2024 15:25:46 +0200 Niklas Schnelle <schnelle@linux.ibm.com> wrote:

> Hi Andrew,
> 
> This is a follow up in my ongoing effort of making inb()/outb() and
> similar I/O port accessors compile-time optional. Previously I sent this
> as a treewide series titled "treewide: Remove I/O port accessors for
> HAS_IOPORT=n" with the latest being its 5th version[0]. With a significant
> subset of patches merged I've changed over to per-subsystem series. These
> series are stand alone and should be merged via the relevant tree such
> that with all subsystems complete we can follow this up with the final
> patch that will make the I/O port accessors compile-time optional.
> 
> The current state of the full series with changes to the remaining
> subsystems and the aforementioned final patch can be found for your
> convenience on my git.kernel.org tree in the has_ioport_v6 branch[1] with
> signed tags. As for compile-time vs runtime see Linus' reply to my first
> attempt[2].

Thanks.

I'm not fully understanding the timing.  Am I correct in believing that the 44
other patches are not dependent upon this one?  And that this patch is not
dependent upon those 44?

