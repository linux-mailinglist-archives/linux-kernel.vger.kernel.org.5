Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4FC788BB8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343661AbjHYO36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343928AbjHYOR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:17:56 -0400
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9740E2D57;
        Fri, 25 Aug 2023 07:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=buaa.edu.cn; s=buaa; h=Received:Message-ID:Date:MIME-Version:
        User-Agent:Subject:To:Cc:References:From:In-Reply-To:
        Content-Type:Content-Transfer-Encoding; bh=T2DqUhMnd4YMy7tglb4aX
        fguTgMnQNfIx5OwUgrtPHU=; b=XJKmblM3T1icFRnJwpvV2edq2iM01nrQVVz4V
        ezsVLQqp7XsPgdoywDmZYw52M/3U61ViDbGQ1IetH55s+6D73JwhkTEDHOqgCjC6
        70AzUBtPpd3sb+Xszpa/r6FohI6d8ggC66lbR2fHniFZxwazVeHmFruXDvc38Oeu
        T5Eo3g=
Received: from [10.193.157.69] (unknown [10.193.157.69])
        by coremail-app2 (Coremail) with SMTP id Nyz+CgDXm+Ejt+hkBuoUAA--.55443S3;
        Fri, 25 Aug 2023 22:13:55 +0800 (CST)
Message-ID: <e6662867-9296-4e40-ba1d-5bb56a80eaff@buaa.edu.cn>
Date:   Fri, 25 Aug 2023 22:13:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bluetooth: fix consistent connection failure caused
 by the loss of HCI_Connection_Complete event
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Xin-Yu Liu <by2239112@buaa.edu.cn>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, baijiaju@buaa.edu.cn,
        sy2239101@buaa.edu.cn, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CABBYNZKQi+Ma3spkJcn-FrhojsMCVxQqhW_Mhp5Z42u8_f2vBw@mail.gmail.com>
From:   Xin-Yu Liu <LXYbhu@buaa.edu.cn>
In-Reply-To: <CABBYNZKQi+Ma3spkJcn-FrhojsMCVxQqhW_Mhp5Z42u8_f2vBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Nyz+CgDXm+Ejt+hkBuoUAA--.55443S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWr1DCFy3CFy5Cr4UKr4fGrg_yoW5GFWfpa
        y0kFZxCFWkJwnxJF9rAw48XF1qkw1vgF43trWqvryrA390vrZ7KF40krZIvay5urZ5GF40
        vF4jqrnxKF15C3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_Zr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
        AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
        6r4j6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IY64vIr41lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v
        1sIEY20_Aw1UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
        CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2-VyUUUUU
X-CM-SenderInfo: te1sjjazrrjqpexdthxhgxhubq/
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for your reply!

After receiving your guidance, we implement the code changes you
provided to us and find that the bug has indeed been resolved.

Thank you for your time, support, and for sharing your knowledge.
We look forward to continuing our involvement in the Linux community
and hope to contribute positively, just as you have done.

Best regards,
Xin-Yu Liu

2023/8/24 5:26, Luiz Augusto von Dentz wrote:
> Hi,
>
> On Wed, Aug 23, 2023 at 5:52 AM Xin-Yu Liu <by2239112@buaa.edu.cn> wrote:
>> During a connection attempt, if the HCI_Connection_Complete event
>> is lost and not received by the Host, it will result in
>> a connection failure.
>> In that process, the hci_conn, the handle of which is still
>> HCI_CONN_HANDLE_UNSET, will not be removed from the conn_hash
>> as it would during a regular disconnection opration.
>> Consequently, when an ACL connection is initiated for the same device,
>> the hci_conn is found in hash_conn based on "ba", with its state remaining
>> BT_CONNECT. Then the Host will send an HCI_Create_Connection_Cancel
>> command, which will result in subsequent Bluetooth connections
>> for the same device consistently failing.
>>
>> In order to solve the potential bug, if the hci_conn's state is
>> BT_CONNECT and handle is HCI_CONN_HANDLE_UNSET, remove this hci_conn
>> from conn_hash. This adjustment could potentially help ensure that the
>> specific conn is cleaned up at the appropriate times, then the subsequent
>> connection for the same device will no longer experience failures.
>>
>> Signed-off-by: Xin-Yu Liu <by2239112@buaa.edu.cn>
>> ---
>>   net/bluetooth/hci_conn.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>> index 76222565e..219c62579 100644
>> --- a/net/bluetooth/hci_conn.c
>> +++ b/net/bluetooth/hci_conn.c
>> @@ -2886,6 +2886,10 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
>>                  } else if (conn->type == ACL_LINK) {
>>                          if (conn->hdev->hci_ver < BLUETOOTH_VER_1_2)
>>                                  break;
>> +                       if (conn->state == HCI_CONN_HANDLE_UNSET) {
>> +                               hci_conn_cleanup(conn);
>> +                               break;
>> +                       }
> This won't apply upstream if you are wondering why CI hasn't managed
> to pick it up, this should be fixed by the following line if
> connection cannot be aborted:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/bluetooth/hci_sync.c?id=c452805643ff9762626f2c87c2640ab7c7099eb8#n5432
>
>>                          r = hci_send_cmd(conn->hdev,
>>                                           HCI_OP_CREATE_CONN_CANCEL,
>>                                           6, &conn->dst);
>> --
>> 2.25.1
>>
>

