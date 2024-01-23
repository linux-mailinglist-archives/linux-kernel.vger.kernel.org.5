Return-Path: <linux-kernel+bounces-35680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5284839513
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DD45B27855
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282A57FBB3;
	Tue, 23 Jan 2024 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tb5AWblJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7341F7FBAD
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 16:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027865; cv=none; b=H8fLAVH0b+UphGvrfeGImaRkhGCpyBP7PifwfMYdnx3v2NivD8G/18t5bffEimDx2q1b5ESulOwv8rhNFQSfXOKr8P3LxrHX+kNljnnvy/eVS2MI1S0s7z6Xb41QC4qG4VYKOe4rIUQ6hKZHTM+4NTV8Ayr/rshNMD3A2RKWP2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027865; c=relaxed/simple;
	bh=HM1JWMsVS3aO+e6s9uXhxDnTkudCCSPnQhcGMX1cGFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GG4Nl3O0TYmOnLGHiVc1CuSK7C18oTadpSih1k7gdYIbyWwScCBlZQQdiy1wsMchPAOy2g2jGgITgp5x550e8J59LMzoAqOI1UgXrhct8Akid1n/UQ3E84P5VnYEv43clVQljLOeamjJ0bvpNolm1ZL5AA2U6G/t7JAZktvV4Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tb5AWblJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F03C433F1;
	Tue, 23 Jan 2024 16:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706027864;
	bh=HM1JWMsVS3aO+e6s9uXhxDnTkudCCSPnQhcGMX1cGFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tb5AWblJDawhMPckj0n/uhVr4rgOADnQgZ5UPGOfnTJxxxVd2xfpVFVLsbMfrv+Gb
	 eTr9gVzTpkK3i+Z75/2P1PpszLQMH1CeiC4GqBp4v+XkGmQFpyL9ctc9GwBvkJFSP1
	 TYWXdPDqm4W8uZeG7HmQO9k8bJJfK9U2+EZ5buu+RAe3iKg3zHH6doBdeoBfsdRJzM
	 i8OZpYmAYUtlZ+wORa4kHZT/mYBKReidwKyMJsq/+wLORfV0I7NEovC/IpCnCAX2Sz
	 XSb0haeMEHYYKqdlFYb7DQmT0K2A9Vc/+h1Lka80zrcJieBAJkywf7EM4b95r7/kRx
	 U5Yrp0g9yMAAg==
Date: Tue, 23 Jan 2024 09:37:41 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme_core: scan namespaces asynchronously
Message-ID: <Za_rVS-0MEr2U731@kbusch-mbp.dhcp.thefacebook.com>
References: <20240118210303.10484-1-stuart.w.hayes@gmail.com>
 <189cde89-9750-476f-8fbb-1c95dc056efb@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <189cde89-9750-476f-8fbb-1c95dc056efb@grimberg.me>

On Mon, Jan 22, 2024 at 11:13:15AM +0200, Sagi Grimberg wrote:
> On 1/18/24 23:03, Stuart Hayes wrote:
> > @@ -3901,19 +3932,25 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
> >   			goto free;
> >   		}
> > +		/*
> > +		 * scan list starting at list offset 0
> > +		 */
> > +		atomic_set(&scan_state.count, 0);
> >   		for (i = 0; i < nr_entries; i++) {
> >   			u32 nsid = le32_to_cpu(ns_list[i]);
> >   			if (!nsid)	/* end of the list? */
> >   				goto out;
> > -			nvme_scan_ns(ctrl, nsid);
> > +			async_schedule_domain(nvme_scan_ns, &scan_state, &domain);
> >   			while (++prev < nsid)
> >   				nvme_ns_remove_by_nsid(ctrl, prev);
> >   		}
> > +		async_synchronize_full_domain(&domain);

You mentioned async scanning was an improvement if you have 1000
namespaces, but wouldn't this be worse if you have very few namespaces?
IOW, the decision to use the async schedule should be based on
nr_entries, right?

