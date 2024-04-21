Return-Path: <linux-kernel+bounces-152532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A882A8AC013
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 18:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3ED91C20B72
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 16:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7111BDDF;
	Sun, 21 Apr 2024 16:14:57 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D1F1B977;
	Sun, 21 Apr 2024 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713716097; cv=none; b=Z9gvS7E2JK1uTffq5YiZhxWGueBMwJ3uWXOx+bo6AyGwgJrjeoe8MDboc/e6JDwtowQploiAO6gDX/Bbkejp7lu0HJ+fJAGr3H6zCxQ0djP2AzgDF4sEI5OFwpNqF7FudtQcIfln/d4YhCAWHLDMAaxdTUHLQ90izVyuWGkJC6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713716097; c=relaxed/simple;
	bh=i8asu7phueFjofz9G7cb82MiQsCYJJIdjb/+30F2E7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d4x1RizfRUxdDhZRN66dglE3GDTSqou8+Xek40QuhDAbHTWNjyBkUjNVPB6kEcMspcF16VacB3tYEQiyN6pdKYnK2OZbtHmNd10Hz76iuvCRbk/BjlyFd+Ij5gh6+EyOX8eSBUFfISMzdgxJM5atUyLnFsioNyj6lG9CP4g0ZEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from xmz-huawei.. (unknown [101.68.80.254])
	by APP-01 (Coremail) with SMTP id qwCowAC3v0dXOyVmdqEDBQ--.35170S2;
	Mon, 22 Apr 2024 00:14:18 +0800 (CST)
From: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
To: bhe@redhat.com
Cc: ajones@ventanamicro.com,
	akpm@linux-foundation.org,
	alexghiti@rivosinc.com,
	aou@eecs.berkeley.edu,
	bjorn@rivosinc.com,
	chenjiahao16@huawei.com,
	conor.dooley@microchip.com,
	jszhang@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	palmer@rivosinc.com,
	patchwork-bot+linux-riscv@kernel.org,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	thunder.leizhen@huawei.com,
	zephray@outlook.com,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mingzheng Xing <xingmingzheng@iscas.ac.cn>
Subject: Re: [PATCH -next v2] riscv: kdump: fix crashkernel reserving problem on RISC-V
Date: Mon, 22 Apr 2024 00:13:57 +0800
Message-Id: <20240421161357.7602-1-xingmingzheng@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZSiQRDGLZk7lpakE@MiWiFi-R3L-srv>
References: <ZSiQRDGLZk7lpakE@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAC3v0dXOyVmdqEDBQ--.35170S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw17XF47uF15AryxGw1UGFg_yoW5trWrpF
	43JF1j9rW8Jry8Jr1kJr15AF1kJr1UCa45Jr13Jr17J3Wjgr1qvr1UGrWUWasxA34rCr17
	Jrn8tw4qqr4UCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wryl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUAxh
	LUUUUU=
X-CM-SenderInfo: 50lqwzhlqj6xxhqjqxpvfd2hldfou0/1tbiBwkOCmYlHKYv6QAAs1

>Hi,
>
>On 10/12/23 at 08:40pm, patchwork-bot+linux-riscv@kernel.org wrote:
>> Hello:
>> 
>> This patch was applied to riscv/linux.git (fixes)
>> by Palmer Dabbelt <palmer@rivosinc.com>:
>
>This patches fixes a regression of one risc-v patch which Andrew picked
>into his akpm tree. Later, Andrew merged those two into one patch, now
>it shows up in next/master as:
>
>39365395046f riscv: kdump: use generic interface to simplify crashkernel reservation
>
>Maybe it can be droppped in risv-v git tree so as not to cause conflict
>when merging.
>

Hi,

If I understand right, after commit[1] is merged into Linus's tree,
commit[2] doesn't need to be merged in, because [1] contains [2]. This may
not have an effect on the master branch. But commit[2] goes into the 6.6.y
branch alone and commit[1] doesn't, which creates a trouble in the 6.6
stable branch.

commit 39365395046f ("riscv: kdump: use generic interface to simplify crashkernel reservation") [1]
commit 1d6cd2146c2b ("riscv: kdump: fix crashkernel reserving problem on RISC-V") [2]

Thanks,
Mingzheng

>Thanks
>Baoquan
>
>> 
>> On Mon, 25 Sep 2023 10:43:33 +0800 you wrote:
>> > When testing on risc-v QEMU environment with "crashkernel="
>> > parameter enabled, a problem occurred with the following
>> > message:
>> > 
>> > [    0.000000] crashkernel low memory reserved: 0xf8000000 - 0x100000000 (128 MB)
>> > [    0.000000] crashkernel reserved: 0x0000000177e00000 - 0x0000000277e00000 (4096 MB)
>> > [    0.000000] ------------[ cut here ]------------
>> > [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/resource.c:779 __insert_resource+0x8e/0xd0
>> > [    0.000000] Modules linked in:
>> > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.6.0-rc2-next-20230920 #1
>> > [    0.000000] Hardware name: riscv-virtio,qemu (DT)
>> > [    0.000000] epc : __insert_resource+0x8e/0xd0
>> > [    0.000000]  ra : insert_resource+0x28/0x4e
>> > [    0.000000] epc : ffffffff80017344 ra : ffffffff8001742e sp : ffffffff81203db0
>> > [    0.000000]  gp : ffffffff812ece98 tp : ffffffff8120dac0 t0 : ff600001f7ff2b00
>> > [    0.000000]  t1 : 0000000000000000 t2 : 3428203030303030 s0 : ffffffff81203dc0
>> > [    0.000000]  s1 : ffffffff81211e18 a0 : ffffffff81211e18 a1 : ffffffff81289380
>> > [    0.000000]  a2 : 0000000277dfffff a3 : 0000000177e00000 a4 : 0000000177e00000
>> > [    0.000000]  a5 : ffffffff81289380 a6 : 0000000277dfffff a7 : 0000000000000078
>> > [    0.000000]  s2 : ffffffff81289380 s3 : ffffffff80a0bac8 s4 : ff600001f7ff2880
>> > [    0.000000]  s5 : 0000000000000280 s6 : 8000000a00006800 s7 : 000000000000007f
>> > [    0.000000]  s8 : 0000000080017038 s9 : 0000000080038ea0 s10: 0000000000000000
>> > [    0.000000]  s11: 0000000000000000 t3 : ffffffff80a0bc00 t4 : ffffffff80a0bc00
>> > [    0.000000]  t5 : ffffffff80a0bbd0 t6 : ffffffff80a0bc00
>> > [    0.000000] status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
>> > [    0.000000] [<ffffffff80017344>] __insert_resource+0x8e/0xd0
>> > [    0.000000] ---[ end trace 0000000000000000 ]---
>> > [    0.000000] Failed to add a Crash kernel resource at 177e00000
>> > 
>> > [...]
>> 
>> Here is the summary with links:
>>   - [-next,v2] riscv: kdump: fix crashkernel reserving problem on RISC-V
>>     https://git.kernel.org/riscv/c/1d6cd2146c2b
>
>
>> 
>> You are awesome, thank you!
>> -- 
>> Deet-doot-dot, I am a bot.
>> https://korg.docs.kernel.org/patchwork/pwbot.html
>> 


