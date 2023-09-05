Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFAC792AAD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343668AbjIEQlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354438AbjIELhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:37:52 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C9A1AB;
        Tue,  5 Sep 2023 04:37:45 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qdUNJ-0007xD-Bz; Tue, 05 Sep 2023 13:37:41 +0200
Message-ID: <faa245bf-e925-45b0-9827-b0c9c117e06c@leemhuis.info>
Date:   Tue, 5 Sep 2023 13:37:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Lexar NM790 SSDs are not recognized anymore after 6.1.50 LTS
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Claudio Sampaio <patola@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux NVMe <linux-nvme@lists.infradead.org>,
        Linux Stable <stable@vger.kernel.org>
References: <8af186ba-5f64-2102-8f9c-3969b0906893@gmail.com>
Content-Language: en-US, de-DE
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <8af186ba-5f64-2102-8f9c-3969b0906893@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1693913865;cc8632e6;
X-HE-SMSGID: 1qdUNJ-0007xD-Bz
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.09.23 13:07, Bagas Sanjaya wrote:
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
>
>> I bought a new 4 TB Lexar NM790 and I was using kernel 6.3.13 at the time. It wasn't recognized, with these messages in dmesg:
>>
>> [ 358.950147] nvme nvme0: pci function 0000:06:00.0
>> [ 358.958327] nvme nvme0: Device not ready; aborting initialisation, CSTS=0x0
>>
>> My other NVMe appears correctly in the nvme list though.
>>
>>
>> So I tried using other kernels I had installed at the time: 6.3.7, 6.4.10, 6.5.0rc6, 6.5.0, 6.5.1 and none of these recognized the disk.
>> I installed the 6.1.50 lts kernel from arch repositories (I can compile my own too if this would be an issue) and then the device was correctly recognized:
>>
>> [    4.654613] nvme 0000:06:00.0: platform quirk: setting simple suspend
>> [    4.654632] nvme nvme0: pci function 0000:06:00.0
>> [    4.667290] nvme nvme0: allocated 40 MiB host memory buffer.
>> [    4.709473] nvme nvme0: 16/0/0 default/read/poll queues

FWIW, the quoted mail missed one crucial detail:
"""
 Claudio Sampaio 2023-09-02 19:04:29 UTC

Adding the two lines

│ 3457   { PCI_DEVICE(0x1d97, 0x1602), /* Lexar NM790 */
│ 3458   │ .driver_data = NVME_QUIRK_BOGUS_NID, },

in file drivers/nvme/host/pci.c made my NVMe work correctly. Compiled a
new 6.5.1 kernel and everything works.
"""

@NVME maintainers: is there anything more you need from Claudio at this
point?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
