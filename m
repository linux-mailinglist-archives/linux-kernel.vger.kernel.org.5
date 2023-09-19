Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AF77A5E8A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjISJss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjISJsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:48:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB1AF3;
        Tue, 19 Sep 2023 02:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695116900; x=1695721700; i=efault@gmx.de;
 bh=ZJ0CgXWPtEvjyvQFwxbEyIEcvT/VDsVXiQlXbHd5pEc=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=HYSRC5c05Qp57QIX19iejfZsAqywzcQiKoja6o/cWD9YGZ2DOhu08krF/plnRTDEH2YlAdz3MIy
 fwXcd1b90fmn/+8G+BFkyy7Ls8tN06ilCxOVjPsRC8iNKm9WCPYiuzSGKEitJ5XlkctjS1JmbfMTM
 KzISoTFd9I1e0JA4qwCDeBFH0sP73MscYWU7D/uDs5+M1ftKS4aQsI1Wqan5BYDMazblXLMMefllt
 wKvJylYU8RBSTo4OFLJXRbcQD6cWGU22kWel9MxLbhbIm2N3nV2wbXBJF/casOeizlGRkqi6yx0aN
 7o/DTwh4KFcj7yLjeoI/nJgQtP/3Gm9R/1Tw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.104]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLzBj-1qznD03cqf-00I0Vb; Tue, 19
 Sep 2023 11:48:19 +0200
Message-ID: <eb6313e5fb4bdb45df20351967694ebdd105ee2a.camel@gmx.de>
Subject: Re: [PATCH] sched/fair: Do not wakeup-preempt same-prio SCHED_OTHER
 tasks
From:   Mike Galbraith <efault@gmx.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     K Prateek Nayak <kprateek.nayak@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        x86@kernel.org, Chen Yu <yu.c.chen@intel.com>,
        Gautham Shenoy <gautham.shenoy@amd.com>
Date:   Tue, 19 Sep 2023 11:48:18 +0200
In-Reply-To: <ZQljoiSBhZLEFI/G@gmail.com>
References: <20230816134059.GC982867@hirez.programming.kicks-ass.net>
         <169228500414.27769.13366308319134164264.tip-bot2@tip-bot2>
         <21f3d376-17d6-8fb6-5f35-507ea931c0d3@amd.com>
         <02f6a15f094adb3c8d9957b031941d6bd10c2e43.camel@gmx.de>
         <f0859f35-39ec-e5dc-b77a-79162516de31@amd.com>
         <0e153dd25900af70f91e4a73f960320e6daf3c6a.camel@gmx.de>
         <ZQljoiSBhZLEFI/G@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jf/XS+uy31pNwDB1WpOQAbU5X4oJevQUkU0y/cd7aonWjMKNZbg
 w80zwerv1j+SFocsJYJlU9DDbaHPS+pHlr6iWj2Ko9vCWIsP6YlbXi/P4EJadQbltsp4eyy
 9Uw5X9ywqiMxLb82nZh7TekYiBcxYmnVqsU4AYcbAwWzze9eMwzYi1aeltj0/exb/5bBl7i
 7OJo6+FIVISC764rbx3qA==
UI-OutboundReport: notjunk:1;M01:P0:APciL2NUABU=;Oi5zvvD3gtCH2LA/eaFz4SMzUjX
 yANLWNIRRdBvbl8Iptd35btU9qjLijPtjnfGA3jHNkgZh4c7KZL5Rxj3RTZJojVtXT9tyStRV
 q0273oGPnssf3cFdBS6IZiaAM15uTgs66zwS6JpLryppY3yjudtu8UDDrxWNK4TPsxCCPepyj
 2P5IY64DP72F9D/YpB8lUSBTurupqLbTBq2fTi76tD6wD7U8zvUcm7bGGkyRBjmEOfA9VU/qa
 bRGVmjhrGumn1GnWd+KVL0BR/p+TtLC/qB5KVeGQ8fTrHMeMCZzausyRM1/1d+z7QEsOukJVy
 GydAGzHYE7u9L4VdFd1mRLPlVeHkCqRbvf8N8uVsT5kywENFPUC2lJV6bzckxY+2H0Z8eqFpc
 LS+z4AlkLPrGrcxFAlkSD/L9vPeQog3RBGESYqfBBsQ2m//LZyGXJklBvt0vOqpilNbJmROyV
 KjhFfYHv1yu9s61JBgiyAUpbdORVIScJpLwUXRk1AqtvtdPMSpCBFs2/ZvL8LTdUVRQocLBOY
 uFRSv/cPJHuC+9u/4mEorCluNiMia6owYTMVIR28mccSEZHcOCGEXWvoaq+oA8I2EW1Xm6r4L
 lWMnssXoiEyBoEAhYGj6hVaHF1JExwR65a9ClArXWfVAoMultWKj5FtCJGoXypg6qv5y64Us+
 hZdBaYXW2RTcbDFVbkcVcBMhsOY5r0q6J/L8/ONrc4pNR9CQb3QHb63KGO5wdJ23nBnjWPCDS
 IOdPe8WE+2jSOXfrvUVp07MnXPZaPQK8QJsapYU+19IQpfkYO+RwA8j9wheFQukgy9v+g+Zn9
 K/FLHvU1ZnK7kv0TG14t5CTWYxfhQZJqTx8sKdDgk4dA0VY0mMISXp5X1NPE+25Fi/Nfd1py2
 r6wIAA1ICSMcwX4Nu+1s21B0pYZQFZ8U2OTZwDY4Gl5DNKJPqBAFBkv+MThAl99sOX8K7JIRg
 6kLBmfuiZ9gkd22BY/L24c0+kLY=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-09-19 at 11:02 +0200, Ingo Molnar wrote:
>
> BTW., if overscheduling is still an issue...

The trouble I had with overscheduling was mostly about annoying insta-
preempt creating useless overhead, and that the RUN_TO_PARITY thing
ended. All I see now is the expected 60/40 indeed !=3D 50/50, so things
are gonna shift a bit.

Most of the testing I've done lately has been due to fretting over the
desktop perhaps getting the short end of that shift, but after much
poking and prodding, everything seems just fine here.

	-Mike

