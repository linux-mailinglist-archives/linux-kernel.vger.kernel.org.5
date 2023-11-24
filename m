Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CFF7F79A4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjKXQot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 11:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjKXQoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:44:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D300419B3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:44:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48056C433C7;
        Fri, 24 Nov 2023 16:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700844290;
        bh=NJapw9r3ZsOAeD3DLgBX296z/MrigR0DCtZT3hKOuio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T4k9m2a4J9+l7t92XW0tq7E2AGmFIHF8IEv1SRcnzBSfDM0wdUsdiZgHk8vTWBu2N
         W/DWQx5bh/90B+Ovbi3JN+QIgBg15UmPMVAI2Ovf3gpMa6hkHVVHJTKpGkGEchrgpH
         BsqjV3yoAPwlpNOf/KUZNB53n132RYkLmRgmjP60xJVwfVEBkXLZfz0PZch2EGZCHi
         o4gJ2BdTFtzsJBnLv4FmLWhHz61Qvmp5JtblTC7Gl4ZPxnPDvUB0WwZBX+1+aBQ04I
         86rwDeck8aeosh72G27uZtMgOVcFmz9dAJSl41HAntepBR6IJ4hOjq8JfbpYdULEpl
         wEcvPyITv6i0w==
Date:   Fri, 24 Nov 2023 16:44:45 +0000
From:   Simon Horman <horms@kernel.org>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] firmware_loader: Expand Firmware upload
 error codes with firmware invalid error
Message-ID: <20231124164445.GS50352@kernel.org>
References: <20231121-feature_firmware_error_code-v2-1-f879a7734a4e@bootlin.com>
 <20231121173022.3cb2fcad@kernel.org>
 <20231122114325.5bacca5a@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231122114325.5bacca5a@kmaincent-XPS-13-7390>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 11:43:25AM +0100, Köry Maincent wrote:
> On Tue, 21 Nov 2023 17:30:22 -0800
> Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > On Tue, 21 Nov 2023 11:50:35 +0100 Kory Maincent wrote:
> > > No error code are available to signal an invalid firmware content.
> > > Drivers that can check the firmware content validity can not return this
> > > specific failure to the user-space
> > > 
> > > Expand the firmware error code with an additional code:
> > > - "firmware invalid" code which can be used when the provided firmware
> > >   is invalid  
> > 
> > Any idea what this is?
> > 
> > lib/test_firmware.o: warning: objtool: test_fw_upload_prepare() falls through
> > to next function __cfi_test_fw_upload_cancel()
> > 
> > My build shows this on an incremental clang 17 build.
> 
> For my curiosity, how do you get this error?
> 
> Enabling test_firmware and building with W=1 does not show the error.

Hi Kory,

I am able to observe this warning when compiling with clang-16

make LLVM=1 lib/test_firmware.o

...
