Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA56751E94
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbjGMKOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjGMKOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:14:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD71119;
        Thu, 13 Jul 2023 03:14:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 87E1D1F385;
        Thu, 13 Jul 2023 10:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689243254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yESZf5o+g8lL/htPSYTth/5qzyYw57M36VTUgeXJiPw=;
        b=VKWwmDRwJRlT8LxYSbDPb05dHzZEoQvkDWgn6zHRBFZnMwbEs+LjFyiMahZnl1I4owsGVl
        9Tl6+9WcRwPiKUT1YZGyLf8dugKK9pfns0AibtCcX2YNO2lC0lmfOfvYzanrM05+6bcLSl
        uk5PhcjStMwP1S4+41xzfIScYKVKnkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689243254;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yESZf5o+g8lL/htPSYTth/5qzyYw57M36VTUgeXJiPw=;
        b=TL0j7/87sulczK7E21raQGt51x52fHWSSE+QeEL8uoL/EXjtnJWyAleAR65lcGFj7uNo2K
        W+UO2XZgQfQ/JwCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 68FCD133D6;
        Thu, 13 Jul 2023 10:14:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vEclGXbOr2SCZAAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 13 Jul 2023 10:14:14 +0000
Message-ID: <875b1903-bca8-8c6e-79d7-506313bbd56d@suse.de>
Date:   Thu, 13 Jul 2023 12:14:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH blktests v1 2/3] nvme/rc: Avoid triggering host nvme-cli
 autoconnect
Content-Language: en-US
To:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <jsmart2021@gmail.com>,
        Martin Belanger <Martin.Belanger@dell.com>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-3-dwagner@suse.de>
 <9c07e4f6-2cf5-b53b-6b48-bd4df8798ee9@nvidia.com>
 <bz2s6nyjwl6l7yfrd4wtjdtousv23ypcdleckibps5lyjpwi4x@wqq6qqesevpk>
 <39f9977e-b34c-f2dd-d356-8c78414a60d1@nvidia.com>
 <jdsoqllqmrqu5j5bt3fudkksmjskgs4ooodynm6yh3b4oc5scn@t3hydrmbb22f>
 <972a06e0-6841-043e-fc00-db7596f664c4@nvidia.com>
 <cskolyrp3s47gnn4nwtqpfxtafzhpirn3hv7ovhnnzpbb3ll2z@oum3v3n7go6l>
 <6dced1ba-c468-c88e-f861-9c202e803894@nvidia.com>
 <eadl5bkyysdcymgy7ra4hm6cqn6ngcxbyvz2qzg3fdffsssnpo@d3rzegyurzn5>
 <6fa5ec73-e6c6-cf8e-b11f-1a57f0fc34b4@nvidia.com>
 <95210a8a-c70e-c312-2c47-4f5ee9329586@suse.de>
 <bd7c91c4-9528-aaeb-9789-03191dc7761b@nvidia.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <bd7c91c4-9528-aaeb-9789-03191dc7761b@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/23 10:49, Max Gurtovoy wrote:
> 
> 
> On 13/07/2023 9:00, Hannes Reinecke wrote:
>> On 7/13/23 02:12, Max Gurtovoy wrote:
>>>
>>>
>>> On 12/07/2023 15:04, Daniel Wagner wrote:
>>>> On Mon, Jul 10, 2023 at 07:30:20PM +0300, Max Gurtovoy wrote:
>>>>>
>>>>>
>>>>> On 10/07/2023 18:03, Daniel Wagner wrote:
>>>>>> On Mon, Jul 10, 2023 at 03:31:23PM +0300, Max Gurtovoy wrote:
>>>>>>> I think it is more than just commit message.
>>>>>>
>>>>>> Okay, starting to understand what's the problem.
>>>>>>
>>>>>>> A lot of code that we can avoid was added regarding the --context 
>>>>>>> cmdline
>>>>>>> argument.
>>>>>>
>>>>>> Correct and it's not optional to get the tests passing for the fc 
>>>>>> transport.
>>>>>
>>>>> why the fc needs the --context to pass tests ?
>>>>
>>>> A typical nvme test consists out of following steps (nvme/004):
>>>>
>>>> // nvme target setup (1)
>>>>     _create_nvmet_subsystem "blktests-subsystem-1" "${loop_dev}" \
>>>>         "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
>>>>     _add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
>>>>
>>>> // nvme host setup (2)
>>>>     _nvme_connect_subsys "${nvme_trtype}" blktests-subsystem-1
>>>>
>>>>     local nvmedev
>>>>     nvmedev=$(_find_nvme_dev "blktests-subsystem-1")
>>>>     cat "/sys/block/${nvmedev}n1/uuid"
>>>>     cat "/sys/block/${nvmedev}n1/wwid"
>>>>
>>>> // nvme host teardown (3)
>>>>     _nvme_disconnect_subsys blktests-subsystem-1
>>>>
>>>> // nvme target teardown (4)
>>>>     _remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-1"
>>>>     _remove_nvmet_subsystem "blktests-subsystem-1"
>>>>
>>>>
>>>> The corresponding output with --context
>>>>
>>>>   run blktests nvme/004 at 2023-07-12 13:49:50
>>>> // (1)
>>>>   loop0: detected capacity change from 0 to 32768
>>>>   nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>>>>   nvme nvme2: NVME-FC{0}: create association : host wwpn 
>>>> 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN 
>>>> "blktests-subsystem-1"
>>>>   (NULL device *): {0:0} Association created
>>>>   [174] nvmet: ctrl 1 start keep-alive timer for 5 secs
>>>> // (2)
>>>>   nvmet: creating nvm controller 1 for subsystem 
>>>> blktests-subsystem-1 for NQN 
>>>> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
>>>>   [374] nvmet: adding queue 1 to ctrl 1.
>>>>   [1138] nvmet: adding queue 2 to ctrl 1.
>>>>   [73] nvmet: adding queue 3 to ctrl 1.
>>>>   [174] nvmet: adding queue 4 to ctrl 1.
>>>>   nvme nvme2: NVME-FC{0}: controller connect complete
>>>>   nvme nvme2: NVME-FC{0}: new ctrl: NQN "blktests-subsystem-1"
>>>> // (3)
>>>>   nvme nvme2: Removing ctrl: NQN "blktests-subsystem-1"
>>>> // (4)
>>>>   [1138] nvmet: ctrl 1 stop keep-alive
>>>>   (NULL device *): {0:0} Association deleted
>>>>   (NULL device *): {0:0} Association freed
>>>>   (NULL device *): Disconnect LS failed: No Association
>>>>
>>>>
>>>> and without --context
>>>>
>>>>   run blktests nvme/004 at 2023-07-12 13:50:33
>>>> // (1)
>>>>   loop1: detected capacity change from 0 to 32768
>>>>   nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>>>>   nvme nvme2: NVME-FC{0}: create association : host wwpn 
>>>> 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN 
>>>> "nqn.2014-08.org.nvmexpress.discovery"
>>>
>>> why does this association to discovery controller created ? because 
>>> of some system service ?
>>>
>> Yes. There are nvme-autoconnect udev rules and systemd services 
>> installed per default (in quite some systems now).
>> And it's really hard (if not impossible) to disable these services (as 
>> we cannot be sure how they are named, hence we wouldn't know which 
>> service to disable.
> 
> Right. We shouldn't disable them IMO.
> 
>>
>>> can we configure the blktests subsystem not to be discovered or add 
>>> some access list to it ?
>>>
>> But that's precisely what the '--context' thing is attempting to do ...
> 
> I'm not sure it is.
> 
> Exposing the subsystem is from the target configuration side.
> Additionally, the --context (which is in the initiator/host side), 
> according to Daniel, is there to distinguish between different 
> invocations. I proposed that blktests subsystem will not be part of 
> discoverable fabric or protected somehow by access list. Therefore, no 
> additional invocation will happen.
> 
Hmm. Maybe we can tweak blktest to use it's own HostNQN, and always pass 
that for any nvme-cli call.
Daniel?

Cheers,

Hannes

