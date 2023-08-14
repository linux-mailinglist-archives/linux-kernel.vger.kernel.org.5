Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D4B77BBDF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbjHNOk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjHNOk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:40:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24073F5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:40:26 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692024024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xFaWF1VPCbC+uQA97N7ekQh+GbOSUEPbLIXGhunyUxE=;
        b=2Uiqqxs2NFtSG8+8AuibWxhGDZz9qmWnw1So2QlhUnTOF1SGtGIqkNvIzdGqRqxWDrRdfU
        gUvxa95jWmAFTajnov8lnPKbQE3BzAYGcElMCJi6tGnDMSAfR0GCwdlPFJvNg2if0OqMm/
        SJZ6cBAMQplJlybxWIZWHY/vH1LGKb35NcB6Wj16KZlBohntD1yGgcphUONqVmw2jhuxgw
        ujVOHymW+rUGGnIEv+clLDpWDWJyRskNbfOGzX25Urdi4Qwu2ilz+QLOngsCee+wR/RH6N
        w7/YKaa9OzKdGvgKeyIJKovTr+TQwNXpeokBPbOrYij8aUY1uEgjbxn/YzkaEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692024024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xFaWF1VPCbC+uQA97N7ekQh+GbOSUEPbLIXGhunyUxE=;
        b=d4H10t5c2uujL9wBcuchKEdKOGIVxLd3PhyoHqnLqSl3OfXyD0DPwd8T6jYfOQGoxJ4Vam
        JzXhAqFPiaf3cNAw==
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V2 12/37] x86/microcode/intel: Simplify and rename
 generic_load_microcode()
In-Reply-To: <20230814131927.GEZNop39tb9LxSjFLK@fat_crate.local>
References: <20230812194003.682298127@linutronix.de>
 <20230812195728.246048244@linutronix.de>
 <20230814131927.GEZNop39tb9LxSjFLK@fat_crate.local>
Date:   Mon, 14 Aug 2023 16:40:24 +0200
Message-ID: <87leed3cx3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14 2023 at 15:19, Borislav Petkov wrote:
> On Sat, Aug 12, 2023 at 09:58:55PM +0200, Thomas Gleixner wrote:
>> @@ -645,14 +632,12 @@ static enum ucode_state apply_microcode_
>>  	return ret;
>>  }
>>  
>> -static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
>> +static enum ucode_state read_ucode_intel(int cpu, struct iov_iter *iter)
>
> I'd do this ontop:

Sure.
