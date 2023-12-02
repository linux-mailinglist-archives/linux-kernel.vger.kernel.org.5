Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3ED7801EAB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 22:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjLBV2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 16:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBV2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 16:28:52 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F1BE5;
        Sat,  2 Dec 2023 13:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mzmbYFT6eXgeUvFzA1AjZh/++WkproRxrIlBwE1gCY0=; b=L00IxRP0LYY+aPJJMHp1lU47ZA
        J176Pu7GbGT10FCC346cVLmX3g4rokO0HR8qfU7qotr7mZRJxwPbvsTyIGYtKqUjjY6C63yY4Jke0
        Yytq/fZRQsrgejmnx9MZDzaUzJuZ/SkWZ44LwDPyeWhEtGySoc/T/EWn8uCH2HvyFGjz/SsJqXTlJ
        51L/vgsBow83BFz5+SBn8AQpHa5PE31NM3JiuftoaVkYrOsK5SZaA0uqdoMDGhFkSs68EWHG5IjDI
        Ja6wcomXEuo3azj/d/V5rZFelUc41t3Vfy9vL5qf5O6FOnJPAmn7dTkYCjhlcQD8ft6zLjVDRmTp8
        ACZNl36A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r9XXa-006Nv1-0M;
        Sat, 02 Dec 2023 21:28:46 +0000
Date:   Sat, 2 Dec 2023 21:28:46 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Christian Brauner <brauner@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-fsdevel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/5] fs: Add DEFINE_FREE for struct inode
Message-ID: <20231202212846.GQ38156@ZenIV>
References: <20231202211535.work.571-kees@kernel.org>
 <20231202212217.243710-3-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202212217.243710-3-keescook@chromium.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2023 at 01:22:13PM -0800, Kees Cook wrote:
> Allow __free(iput) markings for easier cleanup on inode allocations.

NAK.  That's a bloody awful idea for that particular data type, since
	1) ERR_PTR(...) is not uncommon and passing it to iput() is a bug.
	2) the common pattern is to have reference-consuming primitives,
with failure exits normally *not* having to do iput() at all.

Please, don't.
