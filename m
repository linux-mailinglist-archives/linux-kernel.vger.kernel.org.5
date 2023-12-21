Return-Path: <linux-kernel+bounces-8322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E90FF81B5A9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CEDC1F243AD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108116F601;
	Thu, 21 Dec 2023 12:19:32 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C592206F;
	Thu, 21 Dec 2023 12:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9193E68B05; Thu, 21 Dec 2023 13:19:25 +0100 (CET)
Date: Thu, 21 Dec 2023 13:19:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, jaswin@linux.ibm.com, bvanassche@acm.org
Subject: Re: [PATCH v2 00/16] block atomic writes
Message-ID: <20231221121925.GB17956@lst.de>
References: <b8b0a9d7-88d2-45a9-877a-ecc5e0f1e645@oracle.com> <20231213154409.GA7724@lst.de> <c729b03c-b1d1-4458-9983-113f8cd752cd@oracle.com> <20231219051456.GB3964019@frogsfrogsfrogs> <20231219052121.GA338@lst.de> <76c85021-dd9e-49e3-80e3-25a17c7ca455@oracle.com> <20231219151759.GA4468@lst.de> <fff50006-ccd2-4944-ba32-84cbb2dbd1f4@oracle.com> <20231221065031.GA25778@lst.de> <b60e39ce-04bf-4ff9-8879-d9e0cf5d84bd@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b60e39ce-04bf-4ff9-8879-d9e0cf5d84bd@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 21, 2023 at 09:49:35AM +0000, John Garry wrote:
> I noticed the NVMe patch to stop always setting virt boundary (thanks), but 
> I am struggling for the wording for iovecs rules. I'd like to reuse 
> iov_iter_is_aligned() to enforce any such rule.
>
> I am thinking:
> - ubuf / iovecs need to be PAGE-aligned
> - each iovec needs to be length of multiple of PAGE_SIZE
>
> But that does not work for total length < PAGE_SIZE.
>
> So then we could have:
> - ubuf / iovecs need to be PAGE-aligned
> - each iovec needs to be length of multiple of atomic_write_unit_min. If 
> total length > PAGE_SIZE, each iovec also needs to be a multiple of 
> PAGE_SIZE.
>
> I'd rather something simpler. Maybe it's ok.

If we decided to not support atomic writes on anything setting a virt
boundary we don't have to care about the alignment of each vector,
and IMHO we should do that as everything else would be a life in
constant pain.  If we really have a use case for atomic writes on
consumer NVMe devices we'll just have to limit it to a single iovec.

