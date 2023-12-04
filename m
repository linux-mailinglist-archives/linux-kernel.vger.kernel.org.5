Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAECA8030B4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbjLDKlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjLDKlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:41:35 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46E4E6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:41:41 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 481AC1F8A8;
        Mon,  4 Dec 2023 10:41:40 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 363D8139E2;
        Mon,  4 Dec 2023 10:41:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id Iv7CC+SsbWUhRQAAn2gu4w
        (envelope-from <dwagner@suse.de>); Mon, 04 Dec 2023 10:41:40 +0000
Date:   Mon, 4 Dec 2023 11:41:39 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC v2 2/3] nvme: move ns id info to struct nvme_ns_head
Message-ID: <27uglzkgku6qeaaodmyb3sudajrkibjiapsg4hjuxy57hohauv@hnpb5zbedyrv>
References: <20231201092735.28592-1-dwagner@suse.de>
 <20231201092735.28592-3-dwagner@suse.de>
 <20231204075134.GB29377@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204075134.GB29377@lst.de>
X-Spamd-Bar: +++++++++
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none);
        spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dwagner@suse.de) smtp.mailfrom=dwagner@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [9.94 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         MID_RHS_NOT_FQDN(0.50)[];
         R_SPF_SOFTFAIL(4.60)[~all:c];
         RCPT_COUNT_FIVE(0.00)[6];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         NEURAL_SPAM_LONG(2.65)[0.757];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spam-Score: 9.94
X-Rspamd-Queue-Id: 481AC1F8A8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 08:51:34AM +0100, Christoph Hellwig wrote:
> > +static void nvme_set_ref_tag(struct nvme_ns_head *head, struct nvme_command *cmnd,
> 
> .. and here.  I'm going to stop now, please also fix up all other
> places.

Sure, I'll update the patch accordingly.

> >  void nvme_failover_req(struct request *req)
> >  {
> > -	struct nvme_ns *ns = req->q->queuedata;
> > +	struct nvme_ns_head *head = req->q->queuedata;
> > +	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
> > +	struct nvme_ns *ns;
> >  	u16 status = nvme_req(req)->status & 0x7ff;
> >  	unsigned long flags;
> >  	struct bio *bio;
> >  
> > -	nvme_mpath_clear_current_path(ns);
> > +	nvme_mpath_clear_current_path(head);
> >  
> >  	/*
> >  	 * If we got back an ANA error, we know the controller is alive but not
> >  	 * ready to serve this namespace.  Kick of a re-read of the ANA
> >  	 * information page, and just try any other available path for now.
> >  	 */
> > -	if (nvme_is_ana_error(status) && ns->ctrl->ana_log_buf) {
> > +	if (nvme_is_ana_error(status) && ctrl->ana_log_buf) {
> > +		ns = nvme_find_get_ns(ctrl, head->ns_id);
> 
> This looks unrelated.

The problem I try to address here is, that we need the ns pointer to
access the ns->flags for ANA state. Given that
nvme_mpath_clear_current_path really wants the ns pointer as well, we
need something like this at the beginning of this function.

As I said, I didn't find any other way to get get from the head pointer
to the ns pointer and this function is the only place where this is
actually necessary to do (avoiding the list scan in nvme_find_get_ns).

> 
> > -bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
> > +bool nvme_mpath_clear_current_path(struct nvme_ns_head *head)
> >  {
> > -	struct nvme_ns_head *head = ns->head;
> >  	bool changed = false;
> >  	int node;
> >  
> > @@ -181,7 +183,7 @@ bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
> >  		goto out;
> >  
> >  	for_each_node(node) {
> > -		if (ns == rcu_access_pointer(head->current_path[node])) {
> > +		if (head == rcu_access_pointer(head->current_path[node])->head) {
> 
> and this can't work.  We need to check the actual ns for the path
> selection, as that's kindof the point.

Okay, makes sense. I'll drop this.

Thanks,
Daniel
