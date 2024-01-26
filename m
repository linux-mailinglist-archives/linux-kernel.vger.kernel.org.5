Return-Path: <linux-kernel+bounces-40281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4695483DD89
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6251C20FEA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C521CF9C;
	Fri, 26 Jan 2024 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0drT4lGQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xTF+SVWx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0drT4lGQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xTF+SVWx"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2171CD3A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283160; cv=none; b=ZRdrWMD+sP+NQ/8rIv3KfZVaA228LvhPYZaRYq/4K0DbpIE7gCCebOKt4lljSYyP7S7tHp3FGkca3QYJuKi6SLSMimZIUHWQLG8ZdWP7IHTgLz7NyLfjlPMkU/E8JGJOZ69m5noQWmRG8NK1Cwa1wOxOCIc6lMvDPZN0OHRhPN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283160; c=relaxed/simple;
	bh=k31NpxeHiQGZOTxGb+Kg9kga4blUsvRmgBWudJ260n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpuRcDsGL3NJV8mx5V9M3Z8axDo7E14pPb78+PXD5W/IS5Z1B+sb9+5eikkXDbLAmoB0zbJeuUDaDyvP/a8fVm8DKI2x2VbsyOKYFv7lNHJpT++hT+Tj/teKvHJSoqTDw5SpPJk0G1tb2G4CjnSDIhn7SaIJRihfllAb1IOAscY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0drT4lGQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xTF+SVWx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0drT4lGQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xTF+SVWx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4BB0321E57;
	Fri, 26 Jan 2024 15:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706283157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+TNxNSzp1WEagRtBVGv/aF71XG+4G8HcGl0DsseuFHM=;
	b=0drT4lGQpvUt4WK4ysownZegDpPOo0EItQQiy7kujasgmnALjjABa1cvwq4df5VJfsKQGo
	fnzT/a2fOWb2JZ8xCAB4Kdw3NzIbY9bN04vK9KvX+ba3L2Ps280dTIm4cjbjjnYf0s/lLJ
	Qhs0h1k645BLVUo5q12aDoyR5opbbFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706283157;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+TNxNSzp1WEagRtBVGv/aF71XG+4G8HcGl0DsseuFHM=;
	b=xTF+SVWxa/MomdsUmzub+0wTDk7HMztkde+0t6Ucyhe+NQgmTzT05KIoIPAGiOznJStQwc
	kG2/3xzjWvh0FNCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706283157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+TNxNSzp1WEagRtBVGv/aF71XG+4G8HcGl0DsseuFHM=;
	b=0drT4lGQpvUt4WK4ysownZegDpPOo0EItQQiy7kujasgmnALjjABa1cvwq4df5VJfsKQGo
	fnzT/a2fOWb2JZ8xCAB4Kdw3NzIbY9bN04vK9KvX+ba3L2Ps280dTIm4cjbjjnYf0s/lLJ
	Qhs0h1k645BLVUo5q12aDoyR5opbbFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706283157;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+TNxNSzp1WEagRtBVGv/aF71XG+4G8HcGl0DsseuFHM=;
	b=xTF+SVWxa/MomdsUmzub+0wTDk7HMztkde+0t6Ucyhe+NQgmTzT05KIoIPAGiOznJStQwc
	kG2/3xzjWvh0FNCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DF1F134C3;
	Fri, 26 Jan 2024 15:32:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xfbCCZXQs2WxBgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 26 Jan 2024 15:32:37 +0000
Date: Fri, 26 Jan 2024 16:32:36 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 08/16] nvmet-fc: untangle cross refcounting objects
Message-ID: <oj5l4uvhmp4hmapvzysq7lkstqcu3mnwq2kp366pipmqlhujam@zylmuxdo5ili>
References: <20231218153105.12717-1-dwagner@suse.de>
 <20231218153105.12717-9-dwagner@suse.de>
 <20231219051648.GA32634@lst.de>
 <l3etc7ia7mx7fc6ko764amf56xrink2vyv3kdirzcuzwfls2nz@wy66e6t4oxbl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <l3etc7ia7mx7fc6ko764amf56xrink2vyv3kdirzcuzwfls2nz@wy66e6t4oxbl>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0drT4lGQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xTF+SVWx
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4BB0321E57
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Thu, Dec 21, 2023 at 10:17:30AM +0100, Daniel Wagner wrote:
> On Tue, Dec 19, 2023 at 06:16:48AM +0100, Christoph Hellwig wrote:
> > On Mon, Dec 18, 2023 at 04:30:56PM +0100, Daniel Wagner wrote:
> > > The live time of the queues are strictly bound to the lifetime of an
> > 
> > > +	struct nvmet_fc_tgt_queue	*_queues[NVMET_NR_QUEUES + 1];
> > >  	struct nvmet_fc_tgt_queue __rcu	*queues[NVMET_NR_QUEUES + 1];
> > 
> > For magic prefixes we use __, not _ in Linux.  But having two arrays
> > of queues right next to each other, once with rcu annotation and one
> > not rings a bit far warning bell to me.  Why do we have both?  When
> > are we supposed to use either?  Why is FC different from rest?
> 
> This is my attempt to solve the problem that after NULLing the rcu
> pointer and wait for an RCU graceperiod I still need to cleanup the
> queues. Thus I need to keep hold on the queue pointers a bit longer.
> Indeed not so elegant.
> 
> I'm sure there is a better way to do it, I just didn't figure it out
> when I wrote this part. Any tips are highly welcomed how to solve this
> puzzle.

Looking at this code again, I don't think we need use RCU for the queues
pointers at all. The association is already under RCU and thus the
queues pointers don't need additional RCUing. We either can lookup the
association or not and the queue pointer's lifetime is under kref rules.
So with this in mind the lookup would be:

	rcu_read_lock();
	list_for_each_entry_rcu(assoc, &tgtport->assoc_list, a_list) {
		if (association_id == assoc->association_id) {
			queue = assoc->queues[qid];
			if (queue &&
			    (!atomic_read(&queue->connected) ||
			     !nvmet_fc_tgt_q_get(queue)))
				queue = NULL;
			rcu_read_unlock();
			return queue;
		}
	}
	rcu_read_unlock();
	return NULL;

No need for more complexity :)

