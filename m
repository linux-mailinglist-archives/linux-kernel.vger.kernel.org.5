Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99D0782D4C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbjHUPbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 11:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjHUPbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:31:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC5BE9;
        Mon, 21 Aug 2023 08:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692631860; x=1693236660; i=efault@gmx.de;
 bh=RvTOcjhkwkdL/XPptRRQ6fgVBPYApdVYW7TRDCKlrcg=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=tor7zYcqKnG63CQPWW83waAFXdCpoLyGIwoePHrHBk+1m9DL2k+YAzWzFgsPgL5h3fydb9+
 rZ8Zm1/yeAElKx2QUzAG/E7ZeIq1E5ZzqI6KByHYgOGa/Ys75meBTEKw+FiLHtnTqWxJ8+UEU
 IYvQtyBDjc2MvINO7JSlkxMk1cjOpgi5dL8rug9wISympa15c0A7Yz/ObyZ3qRrRnxyGvcCoR
 OdXFI/z2Sx27q4GOsoHtYHfzZYK7vU7686UA/mVi5GNE6V0ndnlEtuRwTVbyizvhaHlvAq/wc
 JJmq4w20f/hOrthmNXmD9yYx37Wk28tVm3YCrUK45TiQhFUszNxQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrQEx-1puhdM3zmx-00oSaw; Mon, 21
 Aug 2023 17:31:00 +0200
Message-ID: <02f6a15f094adb3c8d9957b031941d6bd10c2e43.camel@gmx.de>
Subject: Re: [tip: sched/core] sched/eevdf: Curb wakeup-preemption
From:   Mike Galbraith <efault@gmx.de>
To:     K Prateek Nayak <kprateek.nayak@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        x86@kernel.org, Chen Yu <yu.c.chen@intel.com>,
        Gautham Shenoy <gautham.shenoy@amd.com>
Date:   Mon, 21 Aug 2023 17:30:58 +0200
In-Reply-To: <21f3d376-17d6-8fb6-5f35-507ea931c0d3@amd.com>
References: <20230816134059.GC982867@hirez.programming.kicks-ass.net>
         <169228500414.27769.13366308319134164264.tip-bot2@tip-bot2>
         <21f3d376-17d6-8fb6-5f35-507ea931c0d3@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xHTzzPiK0iuD1E4+FVjhO07q5AAny9TWqj4klWjnGgF1JdvwQNo
 XHYgHXqVFKEy5HfMyd8ZTMHx8kh9dzgfNx5nS2lEHSDOea8wGNENJh5dSlOnJRk74Bjd1DH
 S8uTWMnLMh0GnlJqQwasGAnD57xXIhdpEVq+XvHV/3jQM58yzOmQTorK8iPWTaavHZhNnoR
 fXeTVil9taUaT4HzpSbGg==
UI-OutboundReport: notjunk:1;M01:P0:LMz3OiYQf3Q=;B8BMLFYf0rH8cPFFd2k96Sf4E4L
 CIkeFuE9Y0fqr4DpXjKmquVVzOFT7xSXZnO0ecIU6J4CoFsgh7cIoftPwL/pJZZTrsFABxdzr
 pc3lTDBYRChh4gqbMotzQkE11VennwAM+hdiLjZky+VIJLXPTX78k9oHDasP40SxkHY6zN20B
 lQ0IVofDQVBe3Sb/CLFsNw3mGF2mVC2P53Mqb4au6IucQFfjS+9E4SWcHy2GyLr3/uuul75la
 3owq2uTbj3qkBrHHRbXTGNJta2sai0lb4qfQVNHJg3hP2sBMfJGhhfMXEeMY86RdGGGtUWJ5I
 nbyFPrEIiZ7qVey0zF9qGXv2SyAboSV9eJu4q7J0e/iQR+telHWMLcEZFF9t/QwtSunvdgj8M
 H+WV60JCzx6AyYoi8zcDPO8+cdOiyqr3HQe4xlDmktFLxZ2mMaR8nEj7ANGRcrH5+M+yvs+pO
 RF6VLtZkPLgiZN6gjjCSNRNmbm3n0jyk4eV8LtmIB2jwtiI/gxU/HqkIxnctEz1S1aC0YyqXY
 fOtxHZfEy0rzf0IPi/jkzztCA5rhFTK7UVaSz2hDPgCtzF1r6drm5iTgEfQ2Zl4PbTLAAnRsL
 Fs7aDhkIYpZsdt2AlySyZ7pB/tPBDJHNGD9q0ra372q+fEodI4t8LqDuG4ca8+0EmdfM4S4dK
 W5P/TU46bQCkVNQdvDTvyzFSr5BzBNnoKiNJ1RXZzXLVyIhKZngQuJ7Uma537ZB8gYlXR1qei
 wU+ce7tuLrPKmdcEcs0vGxaLag6cRxCanHLENrmiVeN5fRBF7yKvy9aF0jyVWs2znJ0Aqagbw
 m9RaeXHZqqv0GY8vNl06M91Se0e6uDJ4cW54IPKMfwzR2DmxbnXG8EG1t0o3dz+UBVug+9RyW
 4kKLF8W9csUKj8e667F7dmxxK3e0idxgMEnIewXeydjPUVZTk3XCNwaIYlHpDa4NGLYS85MJ/
 MI1sOE5aYkXY9rxvEwifhhOFaAs=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-08-21 at 16:09 +0530, K Prateek Nayak wrote:
> Hello Peter,
>
> Sorry for being late to the party but couple of benchmarks are unhappy
> (very!) with eevdf, even with this optimization. I'll leave the results
> of testing on a dual socket 3rd Generation EPYC System (2 x 64C/128T)
> running in NPS1 mode below.
>
> tl;dr
>
> - Hackbench with medium load, tbench when overloaded, and DeathStarBench
> =C2=A0 are not a fan of EEVDF so far :(

FWIW, there are more tbench shards lying behind EEVDF than in front.

tbench 8 on old i7-4790 box
4.4.302      4024
6.4.11       3668
6.4.11-eevdf 3522

I went a-hunting once, but it didn't go well.  There were a couple
identifiable sched related dips/recoveries, but the overall result was
a useless downward trending mess.

	-Mike
