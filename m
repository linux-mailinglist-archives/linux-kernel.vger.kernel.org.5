Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2613A757CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjGRNMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjGRNMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:12:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D118A19B2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:11:47 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689685905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RTDlBPpCAWMlCzygNavYra7HGcCrmsHiRs9CyAlwtlA=;
        b=xEioDoqswPzTvx1O1yVow95v4FgKlXrTYAmwoJqmnvfz/IDDKv6IAEZedGdDWTKENoi2Bh
        0k6DG2hlVzIRaiOAY4X65xo9Ofnuqs1MFEZTLkEP3wULeDUfyoDGdUkMl0ewzLJJPlrud4
        n19m9N8aDbliyoBlhu0kdVsr+3mR4OVp9PT8yKvFPatrkXOprSbwjeXW/Kygu4tMoMFLhK
        KEhqKRHhmwEJzxmsW50PWp+sgmC8eKTX7xpO4VsUrtLyA48sCLI4qX9RnmLaD68lW1BoKb
        C4v4ag1PUSLVQXK0JREij1DqDPN9jL4JQhUfpzag8QWAyfXf6pjYrVg8BYTktA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689685905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RTDlBPpCAWMlCzygNavYra7HGcCrmsHiRs9CyAlwtlA=;
        b=UgxgYQ6yLhsWci2omoxnQEcQH0DaKLxlS5mExNKLwmuY6wj6UW3ScPN3NWyEZ9k8wGskqd
        sqSTFKNeX+l5PVCQ==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [patch 19/58] x86/apic: Get rid of apic_phys
In-Reply-To: <20230717223224.207131427@linutronix.de>
References: <20230717223049.327865981@linutronix.de>
 <20230717223224.207131427@linutronix.de>
Date:   Tue, 18 Jul 2023 15:11:44 +0200
Message-ID: <87edl5xt2n.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18 2023 at 01:15, Thomas Gleixner wrote:
> @@ -1921,7 +1922,6 @@ static __init void try_to_enable_x2apic(
>  		 * be addressed must not be brought online.
>  		 */
>  		x2apic_set_max_apicid(apic_limit);
> -		x2apic_phys = 1;
>  	}
>  	x2apic_enable();
>  }

This hunk is obviously bogus. I just noticed on a VM which takes this
code path...
