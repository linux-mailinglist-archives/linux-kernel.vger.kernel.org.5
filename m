Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D421A812866
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 07:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443245AbjLNGqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 01:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjLNGqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 01:46:16 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280C3E8;
        Wed, 13 Dec 2023 22:46:19 -0800 (PST)
X-UUID: a8a7e8588f3945dca372922d586ad599-20231214
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:3e35a9ac-60c8-4a01-8c7d-96e47a71c586,IP:5,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-10
X-CID-INFO: VERSION:1.1.33,REQID:3e35a9ac-60c8-4a01-8c7d-96e47a71c586,IP:5,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:-10
X-CID-META: VersionHash:364b77b,CLOUDID:308d2f61-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:231214144607IFAQKYW0,BulkQuantity:0,Recheck:0,SF:19|44|64|66|24|17|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: a8a7e8588f3945dca372922d586ad599-20231214
X-User: chentao@kylinos.cn
Received: from [172.20.15.254] [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1396760837; Thu, 14 Dec 2023 14:46:07 +0800
Message-ID: <ae686e04-b65c-4a4d-b208-076136bae070@kylinos.cn>
Date:   Thu, 14 Dec 2023 14:46:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iavf: Fix null pointer dereference in
 iavf_print_link_message
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        jacob.e.keller@intel.com, przemyslaw.kitszel@intel.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kunwu Chan <kunwu.chan@hotmail.com>
References: <20231211025927.233449-1-chentao@kylinos.cn>
 <20231212132851.59054654@kernel.org>
From:   Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <20231212132851.59054654@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply.
Sure, the only thing 'iavf_print_link_message' do is to print a msg by 
netdev_info.

The 'iavf_virtchnl_completion' assume that no errors will be returned.
Whether we could just execute 'netdev_info(netdev, "NIC Link is Up Speed 
is %s Full Duplex\n", speed? speed :"");' when 'speed' is null.


Before commit '1978d3ead82c8', the buffer size is '#define 
IAVF_MAX_SPEED_STRLEN  13', whether we could use a bigger buffer
size to avoid a null pointer.

Such as '#define IAVF_MAX_SPEED_STRLEN 48'.


On 2023/12/13 05:28, Jakub Kicinski wrote:
> On Mon, 11 Dec 2023 10:59:27 +0800 Kunwu Chan wrote:
>> kasprintf() returns a pointer to dynamically allocated memory
>> which can be NULL upon failure.
>>
>> Fixes: 1978d3ead82c ("intel: fix string truncation warnings")
> 
> No need for the allocation here, print to a buffer on the stack.
