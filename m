Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999307B4E65
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 10:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbjJBI7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 04:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235950AbjJBI7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 04:59:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6F2E9;
        Mon,  2 Oct 2023 01:59:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B38C11F459;
        Mon,  2 Oct 2023 08:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1696237156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qcPUbGA1OPBhP970rKA5RR3bhU0HBzoEh7CfM2ZP+Pw=;
        b=v0I03Ls8yUYfs3AcIaerQ80e6MnUB/wuZoOr+ergWAhoVegiTUhbXD2++Vnyr444VoiOsQ
        K7JwuedU9aqrhLk9uXsd0Sz2i8XEAV2gYnE1qm4VTl42UoOvf6sG1y4ZXwjheRrEMbSSvW
        Is9pBdnECCIkR4/vXFemyefhMpBSne0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1696237156;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qcPUbGA1OPBhP970rKA5RR3bhU0HBzoEh7CfM2ZP+Pw=;
        b=WnXC6kKTWlSx72JCw94CzdZAB7aOBIjwRqcqMUyNvQQ7gEUYmWD/vthTIJjoGL+wCdzpIz
        N1ON2JtlwxsIL9Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 33EAB13456;
        Mon,  2 Oct 2023 08:59:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id W8xPCGSGGmVKNQAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 02 Oct 2023 08:59:16 +0000
Message-ID: <0e0040be-0375-4461-914d-1ea9d04ee62c@suse.de>
Date:   Mon, 2 Oct 2023 10:59:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] cnic,bnx2,bnx2x: use UIO_MEM_DMA_COHERENT
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Leech <cleech@redhat.com>,
        Rasesh Mody <rmody@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
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
 <e0360d8f-6d36-4178-9069-d633d9b7031d@suse.de>
 <2023100114-flatware-mourner-3fed@gregkh>
 <7pq4ptas5wpcxd3v4p7iwvgoj7vrpta6aqfppqmuoccpk4mg5t@fwxm3apjkez3>
 <20231002060424.GA781@lst.de>
 <tf2zu6gqaii2bjipbo2mn2hz64px2624rfcmyg36rkq4bskxiw@zgjzznig6e22>
 <2023100233-salsa-joyous-6d8c@gregkh>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <2023100233-salsa-joyous-6d8c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/23 10:46, Greg Kroah-Hartman wrote:
> On Mon, Oct 02, 2023 at 12:50:21AM -0700, Jerry Snitselaar wrote:
>> On Mon, Oct 02, 2023 at 08:04:24AM +0200, Christoph Hellwig wrote:
>>> On Sun, Oct 01, 2023 at 07:22:36AM -0700, Jerry Snitselaar wrote:
>>>> Changes last year to the dma-mapping api to no longer allow __GFP_COMP,
>>>> in particular these two (from the e529d3507a93 dma-mapping pull for
>>>> 6.2):
>>>
>>> That's complete BS.  The driver was broken since day 1 and always
>>> ignored the DMA API requirement to never try to grab the page from the
>>> dma coherent allocation because you generally speaking can't.  It just
>>> happened to accidentally work the trivial dma coherent allocator that
>>> is used on x86.
>>>
>>
>> re-sending since gmail decided to not send plain text:
>>
>> Yes, I agree that it has been broken and misusing the API. Greg's
>> question was what changed though, and it was the clean up of
>> __GFP_COMP in dma-mapping that brought the problem in the driver to
>> light.
>>
>> I already said the other day that cnic has been doing this for 14
>> years. I'm not blaming you or your __GFP_COMP cleanup commits, they
>> just uncovered that cnic was doing something wrong. My apologies if
>> you took it that way.
> 
> As these devices aren't being made anymore, and this api is really not a
> good idea in the first place, why don't we just leave it broken and see
> if anyone notices?
> 
Guess what triggered this mail thread.
Some customers did notice.

Problem is that these devices were built as the network interface in 
some bladecenter machines, so you can't just replace them with a 
different Ethernet card.

Cheers,

Hannes

