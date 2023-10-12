Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D9F7C70BB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbjJLOuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 10:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbjJLOuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:50:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3328C9;
        Thu, 12 Oct 2023 07:50:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 799A721899;
        Thu, 12 Oct 2023 14:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1697122248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qRi8s5sfeqyTpMVwxuWh8Tu4FuvGYAWMuF5pbEU2cmc=;
        b=MyHU26la+SBovf/7/rTXkCOuUtZcm50rVvHhLgJGcj/nOlYIy3COqkZRgosNyNBPLSJGoL
        xzZfWSr5H62P3PTQdIhXa27VtMjH2MjYaV9HH2D6cv96lxtgsZRs8yp1zCPHCS7Y/aZzR5
        rJ7MfnDe7v81tKImvQ4hjJtazvGfoyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1697122248;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qRi8s5sfeqyTpMVwxuWh8Tu4FuvGYAWMuF5pbEU2cmc=;
        b=wcXAGhPyBQkBQA0rWishPeOTQwq9E7cH7TKUVfEI0vxbJA+aGJK/SSFPwllOAzMIh4FYjm
        Ft+Cz0lIH79qkmDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B5ED139F9;
        Thu, 12 Oct 2023 14:50:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wYn0C8gHKGU2IgAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 12 Oct 2023 14:50:48 +0000
Message-ID: <6329d8a3-3863-4185-8b64-567b4cf8491a@suse.de>
Date:   Thu, 12 Oct 2023 16:50:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REQUEST DISCUSS]: speed up SCSI error handle for host with
 massive devices
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>,
        Mike Christie <michael.christie@oracle.com>,
        Steffen Maier <maier@linux.ibm.com>,
        linux-scsi@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Lee Duncan <lduncan@suse.com>,
        John Garry <john.garry@huawei.com>
Cc:     Wu Bo <wubo40@huawei.com>, Feilong Lin <linfeilong@huawei.com>,
        zhangjian013@huawei.com
References: <71e09bb4-ff0a-23fe-38b4-fe6425670efa@huawei.com>
 <cd7bda98-2160-9271-9520-e98d1fe00ea5@linux.ibm.com>
 <331aafe1-df9b-cae4-c958-9cf1800e389a@huawei.com>
 <64d5a997-a1bf-7747-072d-711a8248874d@suse.de>
 <c4baacf1-0e86-9660-45f7-50ebc853e6af@huawei.com>
 <1dd69d03-b4f6-ab20-4923-0995b40f045d@suse.de>
 <d2f2c89f-c048-4f04-4d95-27958f0fa46a@huawei.com>
 <78d41ec1-b30c-f6d2-811c-e0e4adbc8f01@oracle.com>
 <84b38f16-2a32-f361-43e5-34bce1012e71@oracle.com>
 <769bcd36-4818-8470-2daa-49ac5c05b33a@suse.de>
 <e5f9e720-ddfd-ab8c-c8b9-18ba8ad266f0@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <e5f9e720-ddfd-ab8c-c8b9-18ba8ad266f0@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -7.09
X-Spamd-Result: default: False [-7.09 / 50.00];
         ARC_NA(0.00)[];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         XM_UA_NO_VERSION(0.01)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         MIME_GOOD(-0.10)[text/plain];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[12];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/22 11:40, Wenchao Hao wrote:
> On 2022/4/4 13:28, Hannes Reinecke wrote:
>> On 4/3/22 19:17, Mike Christie wrote:
>>> On 4/3/22 12:14 PM, Mike Christie wrote:
>>>> We could share code with scsi_ioctl_reset as well. Drivers that support
>>>> TMFs via that ioctl already expect queuecommand to be possibly in the
>>>> middle of a run and IO not yet timed out. For example, the code to
>>>> block a queue and reset the device could be used for the new EH and
>>>> SG_SCSI_RESET_DEVICE handling.
>>>>
>>>
>>> Hannes or others,
>>>
>>> How do parallel SCSI drivers support scsi_ioctl_reset? Is is not fully
>>> supported and more only used for controlled testing?
>>
>> That's actually a problem in scsi_ioctl_reset(); it really should wait
>> for all I/O to quiesce. Currently it just sets the 'tmf' flag and calls
>> into the various reset functions.
>>
>> But really, I'd rather get my EH rework in before we're start discussing
>> modifying EH behaviour.
>> Let me repost it ...
>>
> 
> Would you take fast EH(such as single LUN reset) into consideration, maybe
> a second but lightweight EH? It means a lot.
> 
> Or give a way drivers can branch out the general timeout and EH handle logic?

(Re-reading the thread:)

If it's just about device reset I guess we can implement an asynchronous 
version. Based on my EH rework we could / should do:

Have a 'eh_cmd_q' list per 'struct scsi_device' and 'struct
scsi_target'. So Instead of always moving a failed command to the
'eh_cmq_q' list of the host, move it onto the list of the next higher
level (eg a failed abort would move it to the eh_cmq_q of 'struct
scsi_device', a failed device reset would move it to the eh_cmq_q of
'struct scsi_target' etc).
That would actually make the code in SCSI EH easier to read as we
could do away with constantly moving and splitting the per-host
eh_cmq_q list.

And then, as a second step, implement a new eh callback for
asynchronous SCSI device aborts. That callback would need to
stop I/O to the device first, send the TMF, and either
restart the device upon successful completion or splice
the list of failed commands onto the target and call
the normal escalation with skipping eh_device_reset().

Hmm?

Cheers,

Hannes

