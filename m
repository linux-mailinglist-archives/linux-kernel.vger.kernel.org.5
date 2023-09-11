Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF3B79BD79
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239295AbjIKVic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243913AbjIKSSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 14:18:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48A4110
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 11:18:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9DD8B21842;
        Mon, 11 Sep 2023 18:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694456325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QJz0ppghQeuivFed2ka0+o0tWjZ51PoIztp82nSmwVg=;
        b=zNcOZqTqw46PDtGqIqxPVSBE5PGyrRLZmpcKtNfBu/96fPFyNPnKz4sJ6A3zoAq0Qjm+K/
        tYv5zuXzOD4nRxqcejD3iZujmHZj3NrH5EjH+vRZ+kPIanZDVIiiTOCuokyKp9vTeA6h/n
        9VQVO69eJ+XbY9czyLqxKUusMLJQM68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694456325;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QJz0ppghQeuivFed2ka0+o0tWjZ51PoIztp82nSmwVg=;
        b=EH10v/ELGuOTr7D/F51PwMP5+ItlGezPUgeW7ax7mKFr2co2W31ufC86d+rWUBv+R2xASv
        mw1qOEZ6UDXj5SAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F88113780;
        Mon, 11 Sep 2023 18:18:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MGzdIgVa/2SzPAAAMHmgww
        (envelope-from <dwagner@suse.de>); Mon, 11 Sep 2023 18:18:45 +0000
Date:   Mon, 11 Sep 2023 20:19:21 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [RFC v1 4/4] nvmet-discovery: do not use invalid port
Message-ID: <pti3xai6zkvitsqaw54sxut4lpb4qupo4c2n5alesb35ndhxv4@ni7ritoqopfe>
References: <20230829091350.16156-1-dwagner@suse.de>
 <20230829091350.16156-5-dwagner@suse.de>
 <20230905065032.GC19701@lst.de>
 <vml2mmhjurjaalzcmugnu2c4cm4okfkl43swbmudmaotew4gsy@o4q44el473to>
 <ebfmki7mifmo67x27wwrdpabdbiamalj7rsevxvabyi4sff4ck@4d5fyvrjggkw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebfmki7mifmo67x27wwrdpabdbiamalj7rsevxvabyi4sff4ck@4d5fyvrjggkw>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 04:44:47PM +0200, Daniel Wagner wrote:
> On Tue, Sep 05, 2023 at 12:40:25PM +0200, Daniel Wagner wrote:
> > > But I'm still confused how we can get here without req->port
> > > set.  Can you try to do a little more analysis as I suspect we have
> > > a deeper problem somewhere.
> 
> The problem is that nvme/005 starts to cleanup all resources and there
> is a race between the cleanup path and the host trying to figure out
> what's going on (get log page).
> 
> We have 3 association:
> 
>  assoc 0: systemd/udev triggered 'nvme connect-all' discovery controller
>  assoc 1: discovery controller from nvme/005
>  assoc 2: i/o controller from nvme/005

Actually, assoc 1 is also a i/o controller for the same hostnqn as assoc
2. This looks more like it assoc 0 and 1 are both from systemd/udev
trigger. But why the heck is the hostnqn for assoc 1 the same as the
hostnqn we use in blktests? Something is really off here.

The rest of my analysis is still valid.
