Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D823F7566E6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjGQO4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjGQO4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:56:19 -0400
Received: from mail.a-eberle.de (mail.a-eberle.de [213.95.140.213])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B09BE7F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:56:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.a-eberle.de (Postfix) with ESMTP id B2DF1380233
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:56:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aeberle-mx.softwerk.noris.de
Received: from mail.a-eberle.de ([127.0.0.1])
        by localhost (ebl-mx-02.a-eberle.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OhHegj1fnmwa for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 16:56:14 +0200 (CEST)
Received: from gateway.a-eberle.de (unknown [178.15.155.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "sg310.eberle.local", Issuer "A. Eberle GmbH & Co. KG WebAdmin CA" (not verified))
        (Authenticated sender: postmaster@a-eberle.de)
        by mail.a-eberle.de (Postfix) with ESMTPSA
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:56:11 +0200 (CEST)
Received: from svr-exch2019.eberle.local ([192.168.1.17]:29457 helo=webmail.a-eberle.de)
        by gateway.a-eberle.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <Stephan.Wurm@a-eberle.de>)
        id 1qLPdp-0001AV-1p;
        Mon, 17 Jul 2023 16:56:01 +0200
Received: from PC-LX-Wurm (10.10.30.11) by Svr-Exch2019.eberle.local
 (192.168.1.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 17 Jul
 2023 16:56:01 +0200
Date:   Mon, 17 Jul 2023 16:55:58 +0200
From:   Stephan Wurm <stephan.wurm@a-eberle.de>
To:     Richard Weinberger <richard@nod.at>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Johannes Eigner <johannes.eigner@a-eberle.de>
Subject: Re: ubiblock: null pointer dereference using scatterlist in
 work_queue
Message-ID: <ZLVWfrlEOWT1twpr@PC-LX-Wurm>
References: <ZLT2qEYjaWgSpRD6@PC-LX-Wurm>
 <736980270.3262.1689586950735.JavaMail.zimbra@nod.at>
 <ZLUXruUkYMrPK+GQ@PC-LX-Wurm>
 <260741266.3681.1689591789332.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <260741266.3681.1689591789332.JavaMail.zimbra@nod.at>
X-Originating-IP: [10.10.30.11]
X-ClientProxiedBy: Svr-Exch2019.eberle.local (192.168.1.17) To
 Svr-Exch2019.eberle.local (192.168.1.17)
X-EsetResult: clean, is OK
X-EsetId: 37303A298E357D5B677461
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 23-07-17 01:03 schrieb Richard Weinberger:
> Stephan,
>
> ----- Ursprüngliche Mail -----
> > Von: "Stephan Wurm" <stephan.wurm@a-eberle.de>
> >> So reading from ubiblock works as long you don't access it via dm-verity?
> >> How about other stacked devices such as dmcrypt?
> >
> > We did not check other stacked devices, but we'll give this a try.
>
> Please apply this patch too:
>
> diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
> index 75eaecc8639f0..795e2d0f61086 100644
> --- a/drivers/mtd/ubi/block.c
> +++ b/drivers/mtd/ubi/block.c
> @@ -304,7 +304,7 @@ static void ubiblock_do_work(struct work_struct *work)
>          * the number of sg entries is limited to UBI_MAX_SG_COUNT
>          * and ubi_read_sg() will check that limit.
>          */
> -       blk_rq_map_sg(req->q, req, pdu->usgl.sg);
> +       ubi_assert(blk_rq_map_sg(req->q, req, pdu->usgl.sg) > 0);
>
>         ret = ubiblock_read(pdu);
>
>
> I fear the assert will fail. But let's see. :-D
> At least it would explain the NULL deref.

I have now applied the following patch, including yours and additional debug
output around the scatterlist:

diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index 75eaecc8639f..fea959a4b0ef 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -96,6 +96,16 @@ static DEFINE_IDR(ubiblock_minor_idr);
 static DEFINE_MUTEX(devices_mutex);
 static int ubiblock_major;

+static void ubiblock_print_scatterlist(struct ubiblock_pdu *pdu)
+{
+	int ret = sg_nents(&pdu->usgl.sg[0]);
+	for (int i = 0; i < ret; i++) {
+		struct scatterlist *sg = &pdu->usgl.sg[i];
+		pr_warn("sgl[%08d] => %px: page_link=%lu, offset=%d, length=%d",
+			i, sg_virt(sg), sg->page_link, sg->offset, sg->length);
+	}
+}
+
 static int __init ubiblock_set_param(const char *val,
 				     const struct kernel_param *kp)
 {
@@ -304,7 +314,9 @@ static void ubiblock_do_work(struct work_struct *work)
 	 * the number of sg entries is limited to UBI_MAX_SG_COUNT
 	 * and ubi_read_sg() will check that limit.
 	 */
-	blk_rq_map_sg(req->q, req, pdu->usgl.sg);
+	ubi_assert(blk_rq_map_sg(req->q, req, pdu->usgl.sg) > 0);
+
+	ubiblock_print_scatterlist(pdu);

 	ret = ubiblock_read(pdu);

diff --git a/drivers/mtd/ubi/eba.c b/drivers/mtd/ubi/eba.c
index 4e1d80746b04..361e4ce44172 100644
--- a/drivers/mtd/ubi/eba.c
+++ b/drivers/mtd/ubi/eba.c
@@ -748,10 +748,15 @@ int ubi_eba_read_leb_sg(struct ubi_device *ubi, struct ubi_volume *vol,
 			struct ubi_sgl *sgl, int lnum, int offset, int len,
 			int check)
 {
+	static int count[8] = { 0, 0, 0, 0, 0, 0, 0, 0 };
 	int to_read;
 	int ret;
 	struct scatterlist *sg;

+	count[vol->vol_id]++;
+
+	pr_warn("%dnth call of ubi_ea_read_leb_sg", count[vol->vol_id]);
+
 	for (;;) {
 		ubi_assert(sgl->list_pos < UBI_MAX_SG_COUNT);
 		sg = &sgl->sg[sgl->list_pos];

As you can see in following log excerpt, we are able to pass the new assert:

[   49.830833] sgl[00000000] => c30e9000: page_link=4018515232, offset=0, length=4096
[   49.835267] sgl[00000001] => c834f000: page_link=4019190242, offset=0, length=4096
[   49.843009] 46nth call of ubi_ea_read_leb_sg
[   49.862017] sgl[00000000] => c5948000: page_link=4018845954, offset=0, length=4096
[   49.866388] 47nth call of ubi_ea_read_leb_sg
[   49.880518] sgl[00000000] => c5479000: page_link=4018806560, offset=0, length=4096
[   49.884942] sgl[00000001] => c80f6000: page_link=4019171010, offset=0, length=4096
[   49.892720] 48nth call of ubi_ea_read_leb_sg
[   49.913535] sgl[00000000] => c2b1f000: page_link=4018467808, offset=0, length=4096
[   49.917961] sgl[00000001] => c5544000: page_link=4018813056, offset=0, length=4096
[   49.925691] sgl[00000002] => c2bae000: page_link=4018472384, offset=0, length=4096
[   49.933520] sgl[00000003] => c2bad000: page_link=4018472354, offset=0, length=4096
[   49.941239] 49nth call of ubi_ea_read_leb_sg
[   49.955981] sgl[00000000] => c5b77000: page_link=4018863840, offset=0, length=4096
[   49.960476] sgl[00000001] => c834c000: page_link=4019190144, offset=0, length=4096
[   49.968119] sgl[00000002] => c5547000: page_link=4018813152, offset=0, length=4096
[   49.975835] sgl[00000003] => c5bb4000: page_link=4018865792, offset=0, length=4096
[   49.983541] sgl[00000004] => c59e0000: page_link=4018850816, offset=0, length=4096
[   49.991244] sgl[00000005] => c58b8000: page_link=4018841344, offset=0, length=4096
[   49.998942] sgl[00000006] => c818d000: page_link=4019175840, offset=0, length=4096
[   50.006577] sgl[00000007] => c4b3e000: page_link=4018730944, offset=0, length=4096
[   50.014321] sgl[00000008] => c5895000: page_link=4018840224, offset=0, length=4096
[   50.022035] sgl[00000009] => c317b000: page_link=4018519904, offset=0, length=4096
[   50.029735] sgl[00000010] => c52c3000: page_link=4018792544, offset=0, length=4096
[   50.037372] sgl[00000011] => c5822000: page_link=4018836544, offset=0, length=4096
[   50.045105] sgl[00000012] => c557d000: page_link=4018814880, offset=0, length=4096
[   50.052814] sgl[00000013] => c5423000: page_link=4018803808, offset=0, length=4096
[   50.060513] sgl[00000014] => c8289000: page_link=4019183904, offset=0, length=4096
[   50.068221] sgl[00000015] => c8398000: page_link=4019192576, offset=0, length=4096
[   50.075860] sgl[00000016] => c66db000: page_link=4018957152, offset=0, length=4096
[   50.083561] sgl[00000017] => c585b000: page_link=4018838368, offset=0, length=4096
[   50.091263] sgl[00000018] => c801c000: page_link=4019164034, offset=0, length=4096
[   50.098961] 50nth call of ubi_ea_read_leb_sg
[   50.155499] 51nth call of ubi_ea_read_leb_sg
[   50.248918] sgl[00000000] => c59a1000: page_link=4018848800, offset=0, length=4096
[   50.253355] sgl[00000001] => c810c000: page_link=4019171714, offset=0, length=4096
[   50.261120] 52nth call of ubi_ea_read_leb_sg
[   50.277054] sgl[00000000] => c5bb2000: page_link=4018865728, offset=0, length=4096
[   50.281549] sgl[00000001] => c5695000: page_link=4018823840, offset=0, length=4096
[   50.289255] sgl[00000002] => c80db000: page_link=4019170144, offset=0, length=4096
[   50.296894] sgl[00000003] => c50f7000: page_link=4018777824, offset=0, length=4096
[   50.304597] sgl[00000004] => c5c42000: page_link=4018870336, offset=0, length=4096
[   50.312301] sgl[00000005] => c55b8000: page_link=4018816770, offset=0, length=4096
[   50.320108] 53nth call of ubi_ea_read_leb_sg
[   50.333646] sgl[00000000] => c53f2000: page_link=4018802240, offset=0, length=4096
[   50.338065] sgl[00000001] => c5386000: page_link=4018798784, offset=0, length=4096
[   50.345882] sgl[00000002] => c56b0000: page_link=4018824704, offset=0, length=4096
[   50.353646] sgl[00000003] => c6819000: page_link=4018967328, offset=0, length=4096
[   50.361362] sgl[00000004] => c442e000: page_link=4018673088, offset=0, length=4096
[   50.369100] sgl[00000005] => c442c000: page_link=4018673024, offset=0, length=4096
[   50.376736] sgl[00000006] => c4bd6000: page_link=4018735808, offset=0, length=4096
[   50.384444] sgl[00000007] => c4bd4000: page_link=4018735744, offset=0, length=4096
[   50.392152] sgl[00000008] => c4b38000: page_link=4018730752, offset=0, length=4096
[   50.399846] sgl[00000009] => c5cfc000: page_link=4018876290, offset=0, length=4096
[   50.407485] 54nth call of ubi_ea_read_leb_sg
[   50.420878] sgl[00000000] => c5348000: page_link=4018796800, offset=0, length=4096
[   50.425301] sgl[00000001] => c677b000: page_link=4018962272, offset=0, length=4096
[   50.433072] sgl[00000002] => c441d000: page_link=4018672544, offset=0, length=4096
[   50.440781] sgl[00000003] => c4b1f000: page_link=4018729952, offset=0, length=4096
[   50.448486] sgl[00000004] => c4b0f000: page_link=4018729440, offset=0, length=4096
[   50.456121] sgl[00000005] => c5879000: page_link=4018839328, offset=0, length=4096
[   50.463826] sgl[00000006] => c59d8000: page_link=4018850560, offset=0, length=4096
[   50.471528] sgl[00000007] => c566c000: page_link=4018822528, offset=0, length=4096
[   50.479258] sgl[00000008] => c66e1000: page_link=4018957344, offset=0, length=4096
[   50.486894] sgl[00000009] => c53f0000: page_link=4018802176, offset=0, length=4096
[   50.494599] sgl[00000010] => c594e000: page_link=4018846146, offset=0, length=4096
realpath: /dev/disk/by-partuuid//dev/ubiblock0_2: No such file or directory
[   50.502309] 55nth call of ubi_ea_read_leb_sg
[   64.939917] sgl[00000000] => 00000000: page_link=4025764322, offset=0, length=512
[   64.944292] 56nth call of ubi_ea_read_leb_sg
[   64.952594] ==================================================================
[   64.964138] BUG: KASAN: null-ptr-deref in ubi_io_read+0xe8/0x41c
[   64.970203] Read of size 1 at addr 00000000 by task kworker/0:5/75
[   64.976416]
[   64.977930] CPU: 0 PID: 75 Comm: kworker/0:5 Not tainted 6.1.38 #1
[   64.984150] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[   64.990708] Workqueue: ubiblock0_2 ubiblock_do_work
[   64.995654]  unwind_backtrace from show_stack+0x10/0x14
[   65.000943]  show_stack from dump_stack_lvl+0x34/0x48
[   65.006063]  dump_stack_lvl from kasan_report+0xb8/0xe8
[   65.011350]  kasan_report from ubi_io_read+0xe8/0x41c
[   65.016453]  ubi_io_read from ubi_eba_read_leb+0x180/0x68c
[   65.021992]  ubi_eba_read_leb from ubi_eba_read_leb_sg+0x158/0x1fc
[   65.028229]  ubi_eba_read_leb_sg from ubi_leb_read_sg+0x8c/0xdc
[   65.034202]  ubi_leb_read_sg from ubiblock_do_work+0x194/0x428
[   65.040092]  ubiblock_do_work from process_one_work+0x46c/0x98c
[   65.046082]  process_one_work from worker_thread+0x7c/0x7a8
[   65.051718]  worker_thread from kthread+0x158/0x180
[   65.056659]  kthread from ret_from_fork+0x14/0x2c
[   65.061414] Exception stack(0xf0cabfb0 to 0xf0cabff8)
[   65.066504] bfa0:                                     00000000 00000000 00000000 00000000
[   65.074719] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   65.082933] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   65.089578] ==================================================================
[   65.097001] Disabling lock debugging due to kernel taint


> >> Did you print the LEB number, read length and offset in ubiblock_read()?
> >> Maybe there is a bug related to setting up the correct device geometry
> >> and the read request is off.
> > Here is some excerpt from another try with KASAN enabled and full debug output:
>
> Hm, we are within bounds. And looks like other reads worked.
>
> >  ==================================================================
> >  [  293.343675] BUG: KASAN: null-ptr-deref in ubi_io_read+0x1d4/0x46c
> >  [  293.349822] Read of size 1 at addr 00000000 by task kworker/0:3/18
> >  [  293.356037]
> >  [  293.357551] CPU: 0 PID: 18 Comm: kworker/0:3 Not tainted 6.1.36 #1
> >  [  293.363774] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> >  [  293.370331] Workqueue: ubiblock0_2 ubiblock_do_work
> >  [  293.375269]  unwind_backtrace from show_stack+0x10/0x14
> >  [  293.380557]  show_stack from dump_stack_lvl+0x34/0x48
> >  [  293.385668]  dump_stack_lvl from kasan_report+0xb8/0xe8
> >  [  293.390956]  kasan_report from ubi_io_read+0x1d4/0x46c
> >  [  293.396146]  ubi_io_read from ubi_eba_read_leb+0x3c4/0x5cc
> >  [  293.401686]  ubi_eba_read_leb from ubi_eba_read_leb_sg+0x84/0x1f8
> >  [  293.407831]  ubi_eba_read_leb_sg from ubi_leb_read_sg+0xb4/0x110
>
> Can you please double check whether the very first call to ubi_eba_read_leb_sg()
> fails or a later one?
As you can see in above logs, the first calls to ubi_eba_read_leb_sg() originate
from ubiblock_create(). Number 55 and 56 belong to read by cryptsetup.

>
> Thanks,
> //richard

Thanks
--
Stephan Wurm <stephan.wurm@a-eberle.de>
