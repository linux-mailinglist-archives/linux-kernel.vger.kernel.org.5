Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EF480839B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjLGIzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjLGIzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:55:16 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BB610B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 00:55:22 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 85A4C1F86C;
        Thu,  7 Dec 2023 08:55:21 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65FC813976;
        Thu,  7 Dec 2023 08:55:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id t4UOF3mIcWVLPAAAD6G6ig
        (envelope-from <mhocko@suse.com>); Thu, 07 Dec 2023 08:55:21 +0000
Date:   Thu, 7 Dec 2023 09:55:20 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Philipp Rudo <prudo@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Jiri Bohac <jbohac@suse.cz>, Pingfan Liu <piliu@redhat.com>,
        Tao Liu <ltao@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZXGIeAgCcatUDa2h@tiehlicka>
References: <ZWiAsJlLookvCI+h@MiWiFi-R3L-srv>
 <ZWiQ-II9CvGv8EWK@tiehlicka>
 <20231201123353.2b3db7fa@rotkaeppchen>
 <ZWnJyArAmFo_uYPA@tiehlicka>
 <20231201165113.43211a48@rotkaeppchen>
 <ZWoQ1k2AikSiMjys@tiehlicka>
 <20231206120805.4fdcb8ab@rotkaeppchen>
 <ZXB7_rbC0GAkIp7p@tiehlicka>
 <ZXCRF-bvm8ijXxr4@tiehlicka>
 <ZXFIsZ+0GmUZMFk3@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXFIsZ+0GmUZMFk3@MiWiFi-R3L-srv>
X-Rspamd-Queue-Id: 85A4C1F86C
X-Spam-Score: 15.00
X-Spamd-Result: default: False [15.00 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         MID_RHS_NOT_FQDN(0.50)[];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         RCPT_COUNT_SEVEN(0.00)[11];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.00)[32.61%]
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
        spf=fail (smtp-out2.suse.de: domain of mhocko@suse.com does not designate 2a07:de40:b281:104:10:150:64:97 as permitted sender) smtp.mailfrom=mhocko@suse.com
X-Rspamd-Server: rspamd1
X-Spam: Yes
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07-12-23 12:23:13, Baoquan He wrote:
[...]
> We can't guarantee how swift the DMA transfer could be in the cma, case,
> it will be a venture.

We can't guarantee this of course but AFAIK the DMA shouldn't take
minutes, right? While not perfect, waiting for some time before jumping
into the crash kernel should be acceptable from user POV and it should
work around most of those potential lingering programmed DMA transfers.

So I guess what we would like to hear from you as kdump maintainers is
this. Is it absolutely imperative that these issue must be proven
impossible or is a best effort approach something worth investing time
into? Because if the requirement is an absolute guarantee then I simply
do not see any feasible way to achieve the goal of reusable memory.

Let me reiterate that the existing reservation mechanism is showing its
limits for production systems and I strongly believe this is something
that needs addressing because crash dumps are very often the only tool
to investigate complex issues.
-- 
Michal Hocko
SUSE Labs
