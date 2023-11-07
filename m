Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4C47E35E1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 08:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbjKGH1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 02:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjKGH1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 02:27:12 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692F7FC;
        Mon,  6 Nov 2023 23:27:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0F96522A3F;
        Tue,  7 Nov 2023 07:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1699342027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vFRTIA1XBvmMiUidKYSuEiUc8xMwmaYerkhSx7+oP38=;
        b=vHc6HQAXNF6NbgOAjPUsYDNEoH/wtICzTEQkyiUivatOlUEF4GEeOB4trY2OrSzESg/h1Z
        ftLgcfYywfQbL9iG4Zj4ISNIUERSB+mU1fjoUt7XOGkP/K0UBhGCVVApoG9tkxIZS96bpc
        nm5ySxx6RAaJYkS0Uz9KzJNHGMUL3R8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1699342027;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vFRTIA1XBvmMiUidKYSuEiUc8xMwmaYerkhSx7+oP38=;
        b=JwWzSw9nIqSgdBAvM0Nx/6SIZi2VMmzaMdtGV/9UoP9Px0lU9UvCsd/xfgTZKEIPfqq06M
        5SFz0kvC9HbFWbDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 50A18132FD;
        Tue,  7 Nov 2023 07:27:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kEEdEcrmSWVpMgAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 07 Nov 2023 07:27:06 +0000
Message-ID: <a2853642-b79a-4860-abd6-3e218171e491@suse.de>
Date:   Tue, 7 Nov 2023 08:27:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/13] scsi: fnic: Improve logs and add support for
 multiqueue (MQ)
Content-Language: en-US
To:     "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>,
        "Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>
Cc:     "Arulprabhu Ponnusamy (arulponn)" <arulponn@cisco.com>,
        "Dhanraj Jhawar (djhawar)" <djhawar@cisco.com>,
        "Gian Carlo Boffa (gcboffa)" <gcboffa@cisco.com>,
        "Masa Kai (mkai2)" <mkai2@cisco.com>,
        "Satish Kharat (satishkh)" <satishkh@cisco.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231027180302.418676-1-kartilak@cisco.com>
 <20231027180302.418676-14-kartilak@cisco.com>
 <2e7c1749-428b-4c88-8e0e-df6ed4d8def5@suse.de>
 <SJ0PR11MB5896E9241A26DACE35684E12C3AAA@SJ0PR11MB5896.namprd11.prod.outlook.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <SJ0PR11MB5896E9241A26DACE35684E12C3AAA@SJ0PR11MB5896.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/23 21:44, Karan Tilak Kumar (kartilak) wrote:
> On Thursday, November 2, 2023 12:59 AM, Hannes Reinecke <hare@suse.de> wrote:
>> Please move this change to the last patch.
>> And I would wager that this change is more intrusive than a simple patch, so an update to 1.7 or even 2.0 is warranted.
>>
> 
> The version change is in the last patch of the patchset.
> Do you mean that I need to make a separate patch to increment the version number?
> In v3, I'll update it to 1.7.0.0.
> 
Yes, please. And make this the last patch of the patch series.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

