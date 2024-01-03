Return-Path: <linux-kernel+bounces-15331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E99C8822A32
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05A3C1C231D2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D81B182CC;
	Wed,  3 Jan 2024 09:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b="d528Exzx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from zg8tmty3ljk5ljewns4xndka.icoremail.net (zg8tmty3ljk5ljewns4xndka.icoremail.net [167.99.105.149])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ECF18622;
	Wed,  3 Jan 2024 09:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buaa.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=buaa.edu.cn; s=buaa; h=Received:Message-ID:Date:MIME-Version:
	User-Agent:Subject:To:Cc:References:From:In-Reply-To:
	Content-Type:Content-Transfer-Encoding; bh=Pm6lJ0IhFBrXZCrmkzLh+
	tYcwbT7wjYrTM9yR6Jje2Y=; b=d528ExzxWLT7fNhydpwASjLoJy+KyG20qtzLH
	TGP6DyjTsVjUSYixG6KKXF25vGUcnqP9rOyLmT2qjbr4xFvDDm66V2gOgP+M0j4o
	Sj5HUOQ7uBO9hEKBwK5OCKJlgRjuxK751Z52GKH7Z1C82jYdR6eADL5j1TmIMGUK
	XQwPJg=
Received: from [192.168.1.116] (unknown [10.130.147.18])
	by coremail-app1 (Coremail) with SMTP id OCz+CgBXhli7JpVl3FejAA--.47945S2;
	Wed, 03 Jan 2024 17:19:55 +0800 (CST)
Message-ID: <02f35b78-9d0f-44c1-8987-0410b5e216a1@buaa.edu.cn>
Date: Wed, 3 Jan 2024 17:19:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] Bluetooth: rfcomm: Fix null-ptr-deref in
 rfcomm_check_security
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, sy2239101@buaa.edu.cn, buaazhr@buaa.edu.cn
References: <d30e0344-d753-4fa5-9308-5b344c585495@molgen.mpg.de>
From: Yuxuan-Hu <20373622@buaa.edu.cn>
In-Reply-To: <d30e0344-d753-4fa5-9308-5b344c585495@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:OCz+CgBXhli7JpVl3FejAA--.47945S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAw15KFW7Aw18WFW7XFykAFb_yoW5tF13pr
	Z2yFy8KFykur1rAr17JF48ZFyrZw4vgw15Jrn5ZFWYk3s8urn2qryI9ryjga4UCr4vk34U
	AF1UXrZrZrnrZrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24V
	AvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
	McIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF
	04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26F1DJr1UJwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUAkucUUUUU=
X-CM-SenderInfo: ysqtljawssquxxddhvlgxou0/

Hi Paul,


Thank you for your kind reply.

I have made the changes you mentioned and submitted a new version of the 
patch.

https://patchwork.kernel.org/project/bluetooth/patch/20240103091043.3379363-1-20373622@buaa.edu.cn/

On 2024/1/3 16:44, Paul Menzel wrote:
> Dear Yuxuan,
>
>
> Thank you for your patch.
>
> Am 03.01.24 um 04:14 schrieb Yuxuan Hu:
>> During our fuzz testing of the connection and disconnection process 
>> at the
>> RFCOMM layer,we discovered this bug.By comparing the packetsfrom a 
>> normal
>
> 1.  Please add a space after punctuation like full stops/periods and 
> commas. (There are more occurrences below.)
> 2.  packets from
>
>> connection and disconnection process with the testcase that triggered a
>> KASAN report, we analyzed the cause of this bug as follows:
>
> s/, we/. We/
>
>> 1. In the packets captured during a normal connection, the host sends a
>> `Read Encryption Key Size` type of `HCI_CMD` packet(Command Opcode: 
>> 0x1408)
>
> Please add a space before (.
>
>> to the controller to inquire the length of encryption key.After 
>> receiving
>> this packet, the controller immediately replies with a Command Complete
>> packet (Event Code: 0x0e) to return the Encryption Key Size.
>>
>> 2. In our fuzz test case, the timing of the controller's response to 
>> this
>> packet was delayed to an unexpected point: after the RFCOMM and L2CAP
>> layers had disconnected but before the HCI layer had disconnected.
>>
>> 3. After receiving the Encryption Key Size Response at the time 
>> described
>> in point 2, the host still called the rfcomm_check_security function.
>> However, by this time `struct l2cap_conn *conn = 
>> l2cap_pi(sk)->chan->conn;`
>> had already been released, and when the function executed
>> `return hci_conn_security(conn->hcon, d->sec_level, auth_type, 
>> d->out);`,
>> specifically when accessing `conn->hcon`, a null-ptr-deref error 
>> occurred.
>>
>> To fix this bug, check if `sk->sk_state` is BT_CLOSED before calling
>> rfcomm_recv_frame in rfcomm_process_rx.
>
> Is this bug covered by a test case already?


Yes, I have submitted this bug in bugzilla include KASAN details and a 
coverable test case.

Here is the link of it:

https://bugzilla.kernel.org/show_bug.cgi?id=218323


>
>> Signed-off-by: Yuxuan Hu <20373622@buaa.edu.cn>
>> ---
>> V1 -> V2: Removed the direct check for `conn` being null in 
>> rfcomm_check_security
>>
>>   net/bluetooth/rfcomm/core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
>> index 053ef8f25fae..1d34d8497033 100644
>> --- a/net/bluetooth/rfcomm/core.c
>> +++ b/net/bluetooth/rfcomm/core.c
>> @@ -1941,7 +1941,7 @@ static struct rfcomm_session 
>> *rfcomm_process_rx(struct rfcomm_session *s)
>>       /* Get data directly from socket receive queue without copying 
>> it. */
>>       while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
>>           skb_orphan(skb);
>> -        if (!skb_linearize(skb)) {
>> +        if (!skb_linearize(skb) && sk->sk_state != BT_CLOSED) {
>>               s = rfcomm_recv_frame(s, skb);
>>               if (!s)
>>                   break;
>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
>
> Kind regards,
>
> Paul

Sincerely,

Yuxuan


