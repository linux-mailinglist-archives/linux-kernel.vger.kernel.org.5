Return-Path: <linux-kernel+bounces-159180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F898B2A57
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236D31F245DE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1F6155311;
	Thu, 25 Apr 2024 21:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="v3QTKtLT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D31631;
	Thu, 25 Apr 2024 21:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714078888; cv=none; b=N7v3b4C/eBRItoeRkQqKVEI9PtjaHeX4/Y4XNC8F/hMigyNb83ax3tsaXdow3T0Yae/xf2V31o/8CdFYsvAEKB5I8f5azOnwsRgV6xl9dWNTGenchFdIVW6kOWRkKQ/D6uaEQ2JOmjKYQU4bD6mkesjcZVYX4ncK+wJMEREPCYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714078888; c=relaxed/simple;
	bh=WddoWrRbeR1iHMtp/qfJ1PoQ1YAx1kckTTOIrZin9ZU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RPw7MQnaqOHn5xBia+1s88iqxPIV7ofGrTIzHw9EOsu0d9KjET7i9jQp8b9Y6ZihTq2ku4uO9EOJA0iJflvvKWXhGZbkN+MdLAH+sOxQTQ6KRqRGyYb39Tk0h9D71PM++ULXlqh3JqFZ0atG2z52JUeFmywTC/wsRXjKHkCKb/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=v3QTKtLT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60154C113CC;
	Thu, 25 Apr 2024 21:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1714078887;
	bh=WddoWrRbeR1iHMtp/qfJ1PoQ1YAx1kckTTOIrZin9ZU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=v3QTKtLTXH5dOykrJSj2tlJ/7MBrHwawwmkcuOxDVU1yB0fmMRU34CiMK70rfe95P
	 4hh/P4b5ruo+RX4VlrkSOdwBmeaWQIIjhS6884Mj4sYbChmT8Nyro8fcgcdmqK2WAL
	 GH+nvOrLfYJtvey8FB5I1WWI8rfd1wG6C+HCRwaI=
Date: Thu, 25 Apr 2024 14:01:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: ziy@nvidia.com, linux-mm@kvack.org, fstests@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 willy@infradead.org, hare@suse.de, john.g.garry@oracle.com,
 p.raghav@samsung.com, da.gomez@samsung.com
Subject: Re: [PATCH 1/2] mm/huge_memory: skip invalid debugfs file entry for
 folio split
Message-Id: <20240425140126.2a62a5ec686813ee7deea658@linux-foundation.org>
In-Reply-To: <20240424225449.1498244-2-mcgrof@kernel.org>
References: <20240424225449.1498244-1-mcgrof@kernel.org>
	<20240424225449.1498244-2-mcgrof@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Apr 2024 15:54:48 -0700 Luis Chamberlain <mcgrof@kernel.org> wrote:

> If the file entry is too long we may easily end up going out of bounds
> and crash after strsep() on sscanf(). 
> 

Can you explain why?  I'm not seeing it.

