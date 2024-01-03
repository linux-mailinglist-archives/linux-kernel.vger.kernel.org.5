Return-Path: <linux-kernel+bounces-15284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32708229AD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20DA1B22641
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58851805E;
	Wed,  3 Jan 2024 08:45:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB76182A4;
	Wed,  3 Jan 2024 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [172.29.66.158] (93-34-6-18.ip47.fastwebnet.it [93.34.6.18])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 38BA261E5FE01;
	Wed,  3 Jan 2024 09:44:51 +0100 (CET)
Message-ID: <d30e0344-d753-4fa5-9308-5b344c585495@molgen.mpg.de>
Date: Wed, 3 Jan 2024 09:44:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] Bluetooth: rfcomm: Fix null-ptr-deref in
 rfcomm_check_security
To: Yuxuan Hu <20373622@buaa.edu.cn>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, sy2239101@buaa.edu.cn, buaazhr@buaa.edu.cn
References: <20240103031410.3262524-1-20373622@buaa.edu.cn>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240103031410.3262524-1-20373622@buaa.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Yuxuan,


Thank you for your patch.

Am 03.01.24 um 04:14 schrieb Yuxuan Hu:
> During our fuzz testing of the connection and disconnection process at the
> RFCOMM layer,we discovered this bug.By comparing the packetsfrom a normal

1.  Please add a space after punctuation like full stops/periods and 
commas. (There are more occurrences below.)
2.  packets from

> connection and disconnection process with the testcase that triggered a
> KASAN report, we analyzed the cause of this bug as follows:

s/, we/. We/

> 1. In the packets captured during a normal connection, the host sends a
> `Read Encryption Key Size` type of `HCI_CMD` packet(Command Opcode: 0x1408)

Please add a space before (.

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

Is this bug covered by a test case already?

> Signed-off-by: Yuxuan Hu <20373622@buaa.edu.cn>
> ---
> V1 -> V2: Removed the direct check for `conn` being null in rfcomm_check_security
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

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

