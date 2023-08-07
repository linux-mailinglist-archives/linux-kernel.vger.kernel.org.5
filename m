Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD797772649
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjHGNnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbjHGNnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:43:10 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0F8C01FEF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:42:45 -0700 (PDT)
Received: (qmail 124021 invoked by uid 1000); 7 Aug 2023 09:42:17 -0400
Date:   Mon, 7 Aug 2023 09:42:17 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Piyush Mehta <piyush.mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, michal.simek@amd.com,
        siva.durga.prasad.paladugu@amd.com, radhey.shyam.pandey@amd.com,
        git@amd.com, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uas: Add US_FL_NO_ATA_1X for linux tcm_usb_gadget
Message-ID: <3ff288b4-760c-4c8e-a8c2-a6cb4a1447ca@rowland.harvard.edu>
References: <20230807122025.2818062-1-piyush.mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807122025.2818062-1-piyush.mehta@amd.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 05:50:25PM +0530, Piyush Mehta wrote:
> The linux kernel's tcm_usb_gadget requires the US_FL_NO_ATA_1X quirk.
> It does not respond to the ATA_12 family of commands and hangs. The host

Are you certain of that?  Doesn't this depend on the underlying device 
that the gadget is attached to?

> prevents the issuing of ATA_12 commands to the TCM module, by introducing
> this quirk, the host is permitted to proceed with other operations.

Rather than changing just one host (the Linux one) while leaving all 
other hosts to malfunction, why not fix the gadget instead?  Change it 
so that it _doesn't_ hang when it gets an ATA_12 command but returns an 
appropriate error status.  That way the gadget will work with all hosts.

Alan Stern
