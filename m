Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898007CE161
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344713AbjJRPmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbjJRPmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:42:14 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97EE114
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ipBcfsZZpD5KrQh6m7qzHMVdfMYDZ2KFmcuwAv1Ijxo=; b=PMsJGtWoHyCLOZpMSATi+1obwm
        8PRyCjXRZvkDcwzihBWaS53OG9F8YZ6cgzKs8wbldCjrkxJAAYRICILOGcGQbwA+cbahp+LfWfDOO
        c/Og3McKv8poJ802gPUj4Bz5MIrC57XJKKqTy2wyOau3RFlz+pIng2QYLTmQIccBhS9XI3G81iwhh
        HMjh8E8DmT3HUjyuW7nSDkIOVGI1czFAJDW93LTu74vRgOfklB8S7gQa5SEQqQ/YEDq+G2nReuJFI
        zNQKFrAOZe5Zel5qFTyVEV2KHLv5M1WtfAvMfaJMNVX5987IG9mYCWgFWst9X9wpeO1vci2AqBi19
        gsOJAaNA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qt8gP-002QK4-0D;
        Wed, 18 Oct 2023 15:42:05 +0000
Date:   Wed, 18 Oct 2023 16:42:05 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     gus Gusenleitner Klaus <gus@keba.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "David S. Miller" <davem@davemloft.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] amd64: Fix csum_partial_copy_generic()
Message-ID: <20231018154205.GT800259@ZenIV>
References: <VI1PR0702MB3840EB26EF2A1A35BFEA53BFD9D5A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0702MB3840EB26EF2A1A35BFEA53BFD9D5A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 06:18:05AM +0000, gus Gusenleitner Klaus wrote:
> The checksum calculation is wrong in case of an source buffer
> containing zero bytes only. The expected return value is 0, the
> actual return value is 0xfffffff.

Expected where?  The actual checksum is defined modulo 0xffff, so
0 and 0xffffffff represent the same final value.

The only twist is that in some situations we internally use 0 for
"not calculated yet".

> This problem occurs when a ICMP echo reply is sent that has set
> zero identifier, sequence number and data.

What problem?  Could you please either point to specific RFC or
show that packets are rejected by some existing system, or...?
