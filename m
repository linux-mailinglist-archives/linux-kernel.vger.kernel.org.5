Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D14A7B4701
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 12:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbjJAKoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 06:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbjJAKoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 06:44:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A976B7;
        Sun,  1 Oct 2023 03:44:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E3C142184E;
        Sun,  1 Oct 2023 10:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1696157046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KjN8Jj9pXX9nJ/oV/ViQdrLPUA+iQsH1M0z+BUtNsS4=;
        b=W+T0U5VCcSvnv3PZ5nIsaPbS0kynBOBKKcLR41f6b0hVPcutsdyd0DdZ/0j6sDYd8Vt4lC
        LMiRYPwYlhJeOhglhruxRWMrowncDpKpq5R0bL5SkI6tmrxJMnh2bg0uez9CLKyh3WHK7v
        T02WAOhH7P7PaayzaCxI20dot5KOf4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1696157046;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KjN8Jj9pXX9nJ/oV/ViQdrLPUA+iQsH1M0z+BUtNsS4=;
        b=A/oShsgDE03LIuhKodJBq2l80uiUQ72jCQrfyJO/GgdxnSWhHd5ntt5RpR0ymzLXspmpjW
        0x2oBaTTbgly9ODA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6737F132BE;
        Sun,  1 Oct 2023 10:44:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id l84GGHZNGWU7UwAAMHmgww
        (envelope-from <hare@suse.de>); Sun, 01 Oct 2023 10:44:06 +0000
Message-ID: <e0360d8f-6d36-4178-9069-d633d9b7031d@suse.de>
Date:   Sun, 1 Oct 2023 12:44:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] cnic,bnx2,bnx2x: use UIO_MEM_DMA_COHERENT
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chris Leech <cleech@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Rasesh Mody <rmody@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        John Meneghini <jmeneghi@redhat.com>,
        Lee Duncan <lduncan@suse.com>,
        Mike Christie <michael.christie@oracle.com>,
        Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230929170023.1020032-1-cleech@redhat.com>
 <20230929170023.1020032-4-cleech@redhat.com>
 <2023093055-gotten-astronomy-a98b@gregkh>
 <ZRhmqBRNUB3AfLv/@rhel-developer-toolbox>
 <2023093002-unlighted-ragged-c6e1@gregkh>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <2023093002-unlighted-ragged-c6e1@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/23 20:28, Greg Kroah-Hartman wrote:
> On Sat, Sep 30, 2023 at 11:19:20AM -0700, Chris Leech wrote:
>> On Sat, Sep 30, 2023 at 09:06:51AM +0200, Greg Kroah-Hartman wrote:
>>> On Fri, Sep 29, 2023 at 10:00:23AM -0700, Chris Leech wrote:
>>>> Make use of the new UIO_MEM_DMA_COHERENT type to properly handle mmap
>>>> for dma_alloc_coherent buffers.
>>>
>>> Why are ethernet drivers messing around with UIO devices?  That's not
>>> what UIO is for, unless you are trying to do kernel bypass for these
>>> devices without anyone noticing?
>>>
>>> confused,
>>
>> It's confusing. The bnx2 driver stack included a cnic (converged nic?)
>> module that sits between the ethernet drivers (bnx2, bnx2x) and protocol
>> offload drivers (iscsi, fcoe, rdma).
>>
>> The iscsi module (bnx2i) uses a passthrough interface from cnic to
>> handle some network configuration that the device firmware doesn't do.
>> It uses a uio device and a userspace component called iscsiuio to do
>> that.
> 
> That's horrible, and not what the UIO api is for at all.  Configure the
> device like any other normal kernel device, don't poke at raw memory
> values directly, that way lies madness.
> 
> Have a pointer to the userspace tool anywhere?  All I found looks like a
> full IP stack in userspace under that name, and surely that's not what
> this api is for...
> 
But that's how the interface is used, in particular for the bnx2i 
driver. Problem is that the bnx2i iSCSI offload is just that, an iSCSI 
offload. Not a TCP offload. So if the iSCSI interface is configured to
acquire the IP address via DHCP, someone has to run the DHCP protocol.
But the iSCSI offload can't, and the bnx2i PCI device is not a network
device so that the normal network stack can't be used.
And so the architects of the bnx2i card decided to use UIO to pass
the network traffic to userspace, and used the userspace 'iscsiuio'
application to run DHCP in userspace.

But's been that way for several years now; so long, in fact, that
the card itself has been out of support from Marvell (since quite some 
years, too, IIRC). And even the successor of that card (the qedi driver)
is nearing EOL. Mind you, the qedi driver is using the same interface 
(by using UIO to run DHCP in userspace), so singling out the bnx2i for 
bad design can be construed as being unfair :-)

I agree, though, that the design is a mess.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

