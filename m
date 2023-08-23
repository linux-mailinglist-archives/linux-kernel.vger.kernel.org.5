Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DE478540A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbjHWJaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbjHWJYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:24:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7313C46AA;
        Wed, 23 Aug 2023 02:12:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BF0C65A81;
        Wed, 23 Aug 2023 09:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D3DC433C8;
        Wed, 23 Aug 2023 09:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692781938;
        bh=c44X9b2EMrvztK4n2wp/z3wNrDUhUvVuhKC/5Q7w2h0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UjHzrSezgCdpjRBFv8B1WfGS937L04+t2+8HjCAvY2tjBSlNDSCBCTmxCTZE4GgAT
         azndzyA24W9a3ca07bUH/gpIgJfhYcZNvodbs9CzG7OkAW3cKxPtQxKULNliHt/UP7
         BiSXo2sQcbUZYAMPK03hFkRrIibWshWrZ1YzWiDo=
Date:   Wed, 23 Aug 2023 11:12:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     RD Babiera <rdbabiera@google.com>
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        kyletso@google.com, badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: tcpm: set initial svdm version based on
 pd revision
Message-ID: <2023082311-squid-trailing-34dd@gregkh>
References: <20230731165926.1815338-1-rdbabiera@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230731165926.1815338-1-rdbabiera@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 04:59:23PM +0000, RD Babiera wrote:
> When sending Discover Identity messages to a Port Partner that uses Power
> Delivery v2 and SVDM v1, we currently send PD v2 messages with SVDM v2.0,
> expecting the port partner to respond with its highest supported SVDM
> version as stated in Section 6.4.4.2.3 in the Power Delivery v3
> specification. However, sending SVDM v2 to some Power Delivery v2 port
> partners results in a NAK whereas sending SVDM v1 does not.
> 
> NAK messages can be handled by the initiator (PD v3 section 6.4.4.2.5.1),
> and one solution could be to resend Discover Identity on a lower SVDM
> version if possible. But, Section 6.4.4.3 of PD v2 states that "A NAK
> response Should be taken as an indication not to retry that particular
> Command."
> 
> Instead, we can set the SVDM version to the maximum one supported by the
> negotiated PD revision. When operating in PD v2, this obeys Section
> 6.4.4.2.3, which states the SVDM field "Shall be set to zero to indicate
> Version 1.0." In PD v3, the SVDM field "Shall be set to 01b to indicate
> Version 2.0."
> 
> Fixes: c34e85fa69b9 ("usb: typec: tcpm: Send DISCOVER_IDENTITY from dedicated work")
> Cc: stable@vger.kernel.org
> Signed-off-by: RD Babiera <rdbabiera@google.com>
> ---
> Changes since v1:
> * Fixed styling errors.

I'll take this now, but again, your email is failing to be
authenticated.  Perhaps install patatt and sign them that way if
google's email infrastructure isn't going to play nice with patches?

Grabbing thread from lore.kernel.org/all/20230731165926.1815338-1-rdbabiera@google.com/t.mbox.gz
Analyzing 5 messages in the thread
Checking attestation on all messages, may take a moment...
---
  ✗ [PATCH v2] usb: typec: tcpm: set initial svdm version based on pd revision
    + Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com> (✓ DKIM/intel.com)
  ---
  ✗ BADSIG: DKIM/google.com
---
Total patches: 1
---

Hey, if Intel can do it, surely Google can :)

thanks,

greg k-h
