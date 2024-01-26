Return-Path: <linux-kernel+bounces-39496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D996D83D214
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 963B928FA7B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63CD1385;
	Fri, 26 Jan 2024 01:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TB43sQE1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E412264F;
	Fri, 26 Jan 2024 01:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706232562; cv=none; b=J7ZiBnKi3BVeyYAETqGs/T5VDjW3U/gBtqGBtHt5zZhD+KUNhmqJkwD/HPctgsh02kWknhmM9RvsHCSewVfKHB2ucKQiQiIOAFJMkB6Ea82W+F1ouwBQMB6Oe4DbnbThTKZSpFD3Q1hIOv8G+qWeWdjDEO0zNFlcfralAi6i5jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706232562; c=relaxed/simple;
	bh=SpPxz0seanDdh7UOE9i0dvyRYOz2O42i8IrgG1KaPZw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=D8g59rBTqmEfxid2tnif7TWw+GMa9Ju9JjuCDqJUzXKThK/uJDpFkrmz+Xz1OOIHSTinM2Fjanfz445Cb+oVjtgeC9074lSdAkolBSXnxKQqxFlNN7SNXV9i7AW0ttKs22r70YCvV4cRRNC2TVJepR4EiUU2pOLschrHbI500wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TB43sQE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C5FC433C7;
	Fri, 26 Jan 2024 01:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1706232561;
	bh=SpPxz0seanDdh7UOE9i0dvyRYOz2O42i8IrgG1KaPZw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TB43sQE1k7VRyzg4TD869xEAEEP8aVkQMmnhTq8UwA9SkLEPNFIm06InhleV6iIiX
	 cGv/RJ2zf7Mhe64ldqttk3yL9UYrLQMaR52/n2hBh3pc7+kfun8eD17ef5xg4qVhWB
	 YGQGu7O8EJ9funDdhZ4j5i6MXZqaz6GRhZ0YxB/U=
Date: Thu, 25 Jan 2024 17:29:14 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Dave Jiang
 <dave.jiang@intel.com>, Oscar Salvador <osalvador@suse.de>,
 linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, David Hildenbrand <david@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, Huang Ying <ying.huang@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthew Wilcox
 <willy@infradead.org>, linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v7 0/5] Add DAX ABI for memmap_on_memory
Message-Id: <20240125172914.832c8053158a01b7ba731b1f@linux-foundation.org>
In-Reply-To: <20240124-vv-dax_abi-v7-0-20d16cb8d23d@intel.com>
References: <20240124-vv-dax_abi-v7-0-20d16cb8d23d@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jan 2024 12:03:45 -0800 Vishal Verma <vishal.l.verma@intel.com> wrote:

> This series adds sysfs ABI to control memmap_on_memory behavior for DAX
> devices.

Thanks.  I'll add this to mm-unstable for some additional testing, but
I do think we should have the evidence of additional review on this
series's four preparatory patches before proceeding further.


