Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855717D9068
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbjJ0Hz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjJ0HzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:55:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B00C10A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 00:55:21 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698393320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K9MwbxYo3Zz+s8wlirve5DUtjL3E5sUtORHfIvxUsRc=;
        b=zY4beSu/dNr7NSzuAbiWXWwCRmzGSK8niU5q5UR/0g8S9qhdBxuJyuH1QleEkLkPii7RX8
        ZaQA/FbxAD7rHKfdqfs6VjMiAKZ6Vb+6tGAxWnr3H7T3msT7UsA9ti+wxoOnEKZY7JNB0B
        KUDHObh+oRFHpkWfN7hJg/hs5drG8HezUaAMhV6yPcXZfehpNoByScCxZf2SoTM4gNSAg9
        lFb/zT9P0YtWMGwJuAIZ1TtCrtp+hqQ58K7j+mRlzPQgZ8WL0ElGisdCAzRz2GTbtz8cWb
        Ymqyb2HkdJN4AmIrcUJxS1diVFgvVT2gqae/T4ego5l7trEC1TlC3Uke8QkiWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698393320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K9MwbxYo3Zz+s8wlirve5DUtjL3E5sUtORHfIvxUsRc=;
        b=lP8/WtOtKOMDyrsK6buyb7JVHrWWMzUf/RiJr1PjEWwjhrVbk4cxhJpDcWOQamu+VfrIRj
        JzACS02tOWD7cKBw==
To:     Xu Lu <luxu.kernel@bytedance.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, maz@kernel.org, anup@brainfault.org,
        dengliang.1214@bytedance.com, liyu.yukiteru@bytedance.com,
        sunjiadong.lff@bytedance.com, xieyongji@bytedance.com,
        lihangjing@bytedance.com, chaiwen.cc@bytedance.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        =?utf-8?Q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>
Subject: Re: [External] Re: [RFC 00/12] riscv: Introduce Pseudo NMI
In-Reply-To: <CAPYmKFuNr18_jJYZ6X4Rrty=bU0cXiuHpAqSt2+YqDWV6rAveg@mail.gmail.com>
References: <20231023082911.23242-1-luxu.kernel@bytedance.com>
 <CAOnJCUKH0muFHWujXEqJtb4Uv6Kfh5DeJeR2qg9vj7Kc5w43dw@mail.gmail.com>
 <CAPYmKFuNr18_jJYZ6X4Rrty=bU0cXiuHpAqSt2+YqDWV6rAveg@mail.gmail.com>
Date:   Fri, 27 Oct 2023 09:55:19 +0200
Message-ID: <874jic4hzs.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26 2023 at 21:56, Xu Lu wrote:
> On Thu, Oct 26, 2023 at 7:02=E2=80=AFAM Atish Patra <atishp@atishpatra.or=
g> wrote:
> First, please allow me to explain that CSR_IE Pseudo NMI actually can sup=
port
> more than PMU profiling. For example, if we choose to make external major
> interrupt as NMI and use ithreshold or eithreshold in AIA to control whic=
h minor
> external interrupts can be sent to CPU, then we actually can support mult=
iple
> minor interrupts as NMI while keeping the other minor interrupts still
> normal irqs.

What is the use case for these NMIs? Anything else than profiling is not
really possible in NMI context at all.

Thanks,

        tglx
