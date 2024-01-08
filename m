Return-Path: <linux-kernel+bounces-19431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6382C826CC9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1577F1F22560
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725A728E15;
	Mon,  8 Jan 2024 11:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b="otSGCTw2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from zg8tmty3ljk5ljewns4xndka.icoremail.net (zg8tmty3ljk5ljewns4xndka.icoremail.net [167.99.105.149])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D162CCD5;
	Mon,  8 Jan 2024 11:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buaa.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=buaa.edu.cn; s=buaa; h=Received:Message-ID:Date:MIME-Version:
	User-Agent:Subject:To:Cc:References:From:In-Reply-To:
	Content-Type:Content-Transfer-Encoding; bh=+4rCyt0de8rnxrMRRo2pE
	d/n8irU9T6nN4E08mQWVgM=; b=otSGCTw22R5VqHz+VRdyWU+3Qil1aeJMW/d5s
	Wdl9SPUJ0B7B6GU1PW6XpwlLqZNZU3J1O76c//B/Q5r9iZQxguwQGiUgjKTXjNsj
	FjOd4RYT74IPEp9Zbf8dZhPnVEKnAOLZp204krpy/utT/dD0sru6Lb6GSx5rrghL
	zg7v+A=
Received: from [192.168.1.108] (unknown [10.130.147.18])
	by coremail-app1 (Coremail) with SMTP id OCz+CgCXyFpz3JtlRKfJAA--.19759S2;
	Mon, 08 Jan 2024 19:28:51 +0800 (CST)
Message-ID: <6572ae72-0d2e-4c48-9a46-877f46890811@buaa.edu.cn>
Date: Mon, 8 Jan 2024 19:28:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] Bluetooth: rfcomm: Fix null-ptr-deref in
 rfcomm_check_security
To: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 pmenzel@molgen.mpg.de
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, sy2239101@buaa.edu.cn
References: <20240103090238.3376565-1-20373622@buaa.edu.cn>
From: Yuxuan-Hu <20373622@buaa.edu.cn>
In-Reply-To: <20240103090238.3376565-1-20373622@buaa.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:OCz+CgCXyFpz3JtlRKfJAA--.19759S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCw1rKr13Aw1xtFW5XF1UZFb_yoW5WFykpF
	ZFya93Kr1kury5Awn7AF4kZFWrZr1vgr13K395urWUC3s8W3s3KrWSkF1jyayUCFs0k345
	ZF10qa9xKrnFv37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvG1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6c
	xK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK6svPMxAI
	w28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Aw1UJr1UMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
	73UjIFyTuYvjfUOlksUUUUU
X-CM-SenderInfo: ysqtljawssquxxddhvlgxou0/

Dear All:

I hope this email finds you well. I hope you haven't missed my previous 
email, as I understand that everyone has a busy schedule. I just wanted 
to follow up on my previous message sent.

I understand that you may be occupied with other tasks or priorities. 
However, I would greatly appreciate it if you could spare a few moments 
to check the patch in my previous email. Your prompt response would be 
highly valuable to me.

Thank you for your attention to this matter, and I look forward to 
hearing from you soon.


On 2024/1/3 17:02, Yuxuan Hu wrote:
> During our fuzz testing of the connection and disconnection process at the
> RFCOMM layer, we discovered this bug. By comparing the packets from a normal
> connection and disconnection process with the testcase that triggered a
> KASAN report. We analyzed the cause of this bug as follows:
>
> 1. In the packets captured during a normal connection, the host sends a
> `Read Encryption Key Size` type of `HCI_CMD` packet (Command Opcode: 0x1408)
> to the controller to inquire the length of encryption key.After receiving
> this packet, the controller immediately replies with a Command Complete
> packet (Event Code: 0x0e) to return the Encryption Key Size.
>
> 2. In our fuzz test case, the timing of the controller's response to this
> packet was delayed to an unexpected point: after the RFCOMM and L2CAP
> layers had disconnected but before the HCI layer had disconnected.
>
> 3. After receiving the Encryption Key Size Response at the time described
> in point 2, the host still called the rfcomm_check_security function.
> However, by this time `struct l2cap_conn *conn = l2cap_pi(sk)->chan->conn;`
> had already been released, and when the function executed
> `return hci_conn_security(conn->hcon, d->sec_level, auth_type, d->out);`,
> specifically when accessing `conn->hcon`, a null-ptr-deref error occurred.
>
> To fix this bug, check if `sk->sk_state` is BT_CLOSED before calling
> rfcomm_recv_frame in rfcomm_process_rx.
>
> Signed-off-by: Yuxuan Hu <20373622@buaa.edu.cn>
> ---
> V1 -> V2: Check earlier on rfcomm_process_rx
> V2 -> V3: Fixed formatting errors in the commit
>
>   net/bluetooth/rfcomm/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index 053ef8f25fae..1d34d8497033 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -1941,7 +1941,7 @@ static struct rfcomm_session *rfcomm_process_rx(struct rfcomm_session *s)
>   	/* Get data directly from socket receive queue without copying it. */
>   	while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
>   		skb_orphan(skb);
> -		if (!skb_linearize(skb)) {
> +		if (!skb_linearize(skb) && sk->sk_state != BT_CLOSED) {
>   			s = rfcomm_recv_frame(s, skb);
>   			if (!s)
>   				break;


