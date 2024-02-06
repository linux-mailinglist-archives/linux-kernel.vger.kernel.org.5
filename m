Return-Path: <linux-kernel+bounces-55551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1806F84BE06
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1EC42850E4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001E217BBD;
	Tue,  6 Feb 2024 19:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqpYUSnf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3575E17BA3
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 19:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707247371; cv=none; b=bNscjh4ItjcH8QdgpuqmsWrAYAh8/Mdf9kf6UfXmpLjBZ2c2VEtCeL7bvTjxQcz1ETCKlUn51f9mC7zwmpAiI/HDYprMZJOFOmwg89H3bSdbb2l3Z+d13fQRVHZnIZgAb6YzzVMkNBiKFZtarnFiUKBRQchO4GrAGUjD027wDXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707247371; c=relaxed/simple;
	bh=jVV0CP0FliUSGdBrGlooYVmXbC4mj/PMikc4Dao6qR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgfzASUlZNz+mAQrMzDKAAaOhD2nKFa8qifjqJhrADeFWOZf09vH+K9AEC+v8aQbOZG93mldbswqu4FO3ocpbJyUhmTZhDfsBA7UDOq4J3Hz7Tq7fa+LEVDU5wjDRsT4AsPUpLVPfut+zOQBMNQK6QTvIKfV/y/LidX7B1AGZ9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqpYUSnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5B3C433F1;
	Tue,  6 Feb 2024 19:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707247371;
	bh=jVV0CP0FliUSGdBrGlooYVmXbC4mj/PMikc4Dao6qR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XqpYUSnfgzky2tauWjCiKs2wtAODdZJvwiEBQpORZgUg5vznECJbsAZAV8hilPOxb
	 lo4a6Zs55r5Y4bUcn1gImPQSrSfWIAaSpFOORHiP/Qlg080Yc4xyj77oXsnNz6o/Xt
	 4sWG0pTxDBFPWqE7Vj8ldNl4TxF9iOOq8CTiJluiSGwd3HhVAejfM4r+GTPdQEN1Zc
	 8MVqWMWrPmFsKj2hOSXOtluEQnY/bheiZOqrACjh+WgHUeFr7L8adHJie08/2tjTLD
	 E9EI9fBwrqP6IB51z9p5XuIac1/q2mt3GRT94yxMii7nq1OC1a+vVzB6Bqm2VLE95o
	 XVO+/oqp9t1vg==
Date: Tue, 6 Feb 2024 11:22:49 -0800
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>,
	Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 12/12] nvmet-fc: use RCU list iterator for assoc_list
Message-ID: <ZcKHCXtXWVCdi9Ae@kbusch-mbp.mynextlight.net>
References: <20240131085112.21668-1-dwagner@suse.de>
 <20240131085112.21668-13-dwagner@suse.de>
 <b19e0b0f-6b1c-4126-931b-d7b0d01fb3da@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b19e0b0f-6b1c-4126-931b-d7b0d01fb3da@suse.de>

On Tue, Feb 06, 2024 at 02:51:24PM +0900, Hannes Reinecke wrote:
> On 1/31/24 16:51, Daniel Wagner wrote:
> > +		rcu_read_lock();
> > +		if (!nvmet_fc_assoc_exits(tgtport, ran)) {
> >   			assoc->association_id = ran;
> >   			list_add_tail_rcu(&assoc->a_list, &tgtport->assoc_list);
> > +			done = true;
> >   		}
> > +		rcu_read_unlock();
> >   		spin_unlock_irqrestore(&tgtport->lock, flags);
> 
> Odd. You already take the tgtport lock, so there really is no point in using
> rcu_read_lock() here.

That's a interesting point, but I think it's harmless since there's no
rcu sync within the read section.

  https://www.kernel.org/doc/Documentation/RCU/Design/Requirements/Requirements.html#Guaranteed%20Read-to-Write%20Upgrade

That said, the rcu_read_lock() seems like it should be moved to
nvmet_fc_assoc_exits() since that's the only part reading rcu protected
structures.

