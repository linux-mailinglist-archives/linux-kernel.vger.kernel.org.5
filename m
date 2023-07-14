Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DF77535BF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbjGNIxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbjGNIxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:53:44 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0F82120;
        Fri, 14 Jul 2023 01:53:42 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qKEYR-001Re6-UD; Fri, 14 Jul 2023 18:53:37 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 14 Jul 2023 18:53:29 +1000
Date:   Fri, 14 Jul 2023 18:53:29 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v5 00/11] Add dynamic boost control support
Message-ID: <ZLENCbG+Fa20MNsD@gondor.apana.org.au>
References: <20230623135001.18672-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623135001.18672-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 08:49:50AM -0500, Mario Limonciello wrote:
> Dynamic boost control is a feature of some SoCs that allows
> an authenticated entity to send commands to the security processor
> to control certain SOC characteristics with the intention to improve
> performance.
> 
> This is implemented via a mechanism that a userspace application would
> authenticate using a nonce and key exchange over an IOCTL interface.
> 
> After authentication is complete an application can exchange signed
> messages with the security processor and both ends can validate the
> data transmitted.
> 
> This series includes a test suite that can be run on real hardware
> to ensure that the communication works as expected.  This can also be
> used for an application to model the communication path.
> 
> Two sysfs files are introduced for reading the PSP bootloader version
> as well as TEE version which can be useful data points for debugging
> communication problems.
> 
> v4->v5:
>  * Pick up tags
>  * Pick up a static fix
>  * Fix a mistake found in dbc_cli
> 
> Mario Limonciello (11):
>   crypto: ccp: Rename macro for security attributes
>   crypto: ccp: Add support for displaying PSP firmware versions
>   crypto: ccp: Add bootloader and TEE version offsets
>   crypto: ccp: move setting PSP master to earlier in the init
>   crypto: ccp: Add support for fetching a nonce for dynamic boost
>     control
>   crypto: ccp: Add support for setting user ID for dynamic boost control
>   crypto: ccp: Add support for getting and setting DBC parameters
>   crypto: ccp: Add a sample library for ioctl use
>   crypto: ccp: Add a sample python script for Dynamic Boost Control
>   crypto: ccp: Add unit tests for dynamic boost control
>   crypto: ccp: Add Mario to MAINTAINERS
> 
>  Documentation/ABI/testing/sysfs-driver-ccp |  18 ++
>  MAINTAINERS                                |  12 +
>  drivers/crypto/ccp/Makefile                |   3 +-
>  drivers/crypto/ccp/dbc.c                   | 250 +++++++++++++++++++
>  drivers/crypto/ccp/dbc.h                   |  56 +++++
>  drivers/crypto/ccp/psp-dev.c               |  19 +-
>  drivers/crypto/ccp/psp-dev.h               |   1 +
>  drivers/crypto/ccp/sp-dev.h                |   7 +
>  drivers/crypto/ccp/sp-pci.c                |  96 +++++++-
>  include/linux/psp-platform-access.h        |   4 +
>  include/uapi/linux/psp-dbc.h               | 147 ++++++++++++
>  tools/crypto/ccp/.gitignore                |   1 +
>  tools/crypto/ccp/Makefile                  |  13 +
>  tools/crypto/ccp/dbc.c                     |  72 ++++++
>  tools/crypto/ccp/dbc.py                    |  64 +++++
>  tools/crypto/ccp/dbc_cli.py                | 134 +++++++++++
>  tools/crypto/ccp/test_dbc.py               | 266 +++++++++++++++++++++
>  17 files changed, 1146 insertions(+), 17 deletions(-)
>  create mode 100644 drivers/crypto/ccp/dbc.c
>  create mode 100644 drivers/crypto/ccp/dbc.h
>  create mode 100644 include/uapi/linux/psp-dbc.h
>  create mode 100644 tools/crypto/ccp/.gitignore
>  create mode 100644 tools/crypto/ccp/Makefile
>  create mode 100644 tools/crypto/ccp/dbc.c
>  create mode 100644 tools/crypto/ccp/dbc.py
>  create mode 100755 tools/crypto/ccp/dbc_cli.py
>  create mode 100755 tools/crypto/ccp/test_dbc.py
> 
> 
> base-commit: b335f258e8ddafec0e8ae2201ca78d29ed8f85eb
> -- 
> 2.34.1

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
