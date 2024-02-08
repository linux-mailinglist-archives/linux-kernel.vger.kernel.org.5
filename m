Return-Path: <linux-kernel+bounces-58687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBD984E9F7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2731C2266A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BD44B5A7;
	Thu,  8 Feb 2024 20:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="sIFC25qJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0300411CAF
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 20:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707425651; cv=none; b=tm33SmvoCPcBIyWIo+UkXhz091qviAxZtSXVqDr00/12JEdUYHeo4b35N9z/fv+LU8UxP9ipAd2dcBA/dWLEifGsrmF6NStkMl0TKYrKiwf9BYq90KPXJlczab6D9Ep5GlmaqGpkGYoc5T4t3jTso4PpSSbPMjuRAZAgrkXbtRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707425651; c=relaxed/simple;
	bh=lVKgetkWYnLj+KtF4Z88XXytHWtTBc7STnJTaCzNPuI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bOjv/zLbVa0DKwksPrWdhKh5sqydK2Vjc4QEkSr+rE13nUMKtdANGcnKLETUc1lmnnAWRUQZjRUOp5VF+YIbCeS90aQF8hJwTxtVLstC/GAKybDKj9k/IrP7A+jv9KejYPTnkggVdBWvinQ23bZhnv3aBAxapve52rTJ0duktoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=sIFC25qJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45BFC433F1;
	Thu,  8 Feb 2024 20:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1707425650;
	bh=lVKgetkWYnLj+KtF4Z88XXytHWtTBc7STnJTaCzNPuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sIFC25qJpPpWXruDfNT5iyKz8ukpn+X3bfKb1vV/q8CRb5AIudAlJiqVCD/rNtO4X
	 a2IBgZz203bWRu2JPtvlDAgpsltCGUqIrnYXL2fyfMQYw1rvIH5QNDpOBgZf/SwIOn
	 hSk7TlEeiCY5pclrg8GCV7YTV/s2uYqGmtcJPZZE=
Date: Thu, 8 Feb 2024 12:54:09 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Byungchul Park <byungchul@sk.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, ying.huang@intel.com, namit@vmware.com,
 vernhao@tencent.com, mgorman@techsingularity.net, hughd@google.com,
 willy@infradead.org, david@redhat.com, peterz@infradead.org,
 luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [RESEND PATCH v7 7/8] mm: Defer TLB flush by keeping both src
 and dst folios at migration
Message-Id: <20240208125409.28d5aa60d88657405f5c8e1b@linux-foundation.org>
In-Reply-To: <20240208062608.44351-8-byungchul@sk.com>
References: <20240208062608.44351-1-byungchul@sk.com>
	<20240208062608.44351-8-byungchul@sk.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Feb 2024 15:26:07 +0900 Byungchul Park <byungchul@sk.com> wrote:

> Implementation of MIGRC mechanism that stands for 'Migration Read Copy'.

Oh there is it.  Please put this in the [0/N] cover letter?

