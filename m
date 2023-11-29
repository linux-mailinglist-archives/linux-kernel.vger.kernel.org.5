Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3C67FD2E5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjK2Jgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjK2JZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:25:24 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A0710E4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:25:30 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 785EA219AB;
        Wed, 29 Nov 2023 09:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1701249929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=maEght1a46qgiHVXCfLpoV9DyMjUvdyRL12MmWs9td4=;
        b=bfWAsytcvL52/T5h1UAdfnsHwHiYyfcM1ZbAWzl1r4omVn8pIB2H8P/gynzF1Uy57HN8mR
        KPWNxt2wAM6aob3t2o1qo1naQxNSkzkgf1+ppLe5KumP8Flj43vvAXHHp/cgmUmeiGAKCV
        Wio2m/hYQIsgFVJPYK5qktEyVmwVMeI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59CBC13637;
        Wed, 29 Nov 2023 09:25:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id yUTiEokDZ2XsdAAAD6G6ig
        (envelope-from <mhocko@suse.com>); Wed, 29 Nov 2023 09:25:29 +0000
Date:   Wed, 29 Nov 2023 10:25:28 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Jiri Bohac <jbohac@suse.cz>, Pingfan Liu <piliu@redhat.com>,
        Tao Liu <ltao@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZWcDiHNCJDNfCbaq@tiehlicka>
References: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz>
 <CAO7dBbUVQn8xzPZQhhw1XqF+sQT0c6phk4sda+X=MrR6RmPE0A@mail.gmail.com>
 <ZWJllXCN0SDIELrX@dwarf.suse.cz>
 <CAO7dBbVJ=ytRra_77VRZ8ud1wVkP9fub=Vj6cfTkx=CnYg5J2A@mail.gmail.com>
 <ZWVMUxmi66xLZPsr@MiWiFi-R3L-srv>
 <ZWWuBSiZZdF2W12j@tiehlicka>
 <ZWbvB/4bKu69zMbd@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWbvB/4bKu69zMbd@MiWiFi-R3L-srv>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spamd-Result: default: False [-0.80 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[8];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.00)[41.29%]
X-Spam-Score: -0.80
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29-11-23 15:57:59, Baoquan He wrote:
[...]
> Hmm, Redhat could go in a different way. We have been trying to:
> 1) customize initrd for kdump kernel specifically, e.g exclude unneeded
> devices's driver to save memory;
> 2) monitor device and kenrel memory usage if they begin to consume much
> more memory than before. We have CI testing cases to watch this. We ever
> found one NIC even eat up GB level memory, then this need be
> investigated and fixed.

How do you simulate all different HW configuration setups that are using
out there in the wild?
-- 
Michal Hocko
SUSE Labs
