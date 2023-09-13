Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7102F79E6AE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237447AbjIML0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240195AbjIML0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:26:18 -0400
Received: from smtp67.ord1d.emailsrvr.com (smtp67.ord1d.emailsrvr.com [184.106.54.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E05A173E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1694604372;
        bh=EviTs6VTawLw+lToHOPpFX2/rBSg74IWtHHaKlKo1nI=;
        h=Date:Subject:From:To:From;
        b=s6FGYkA6TJr+E+vQ8Ij7Sd6rZUFL82xKkjJeFlYGPPEVyj9xDVXEDJPGUlYNgzPzi
         YZ07D9X9+DfhUTFxJ4MfIicqSh1Crikw4z/xDREUNgGMypiIN7sg2pNwZL90DG/oKd
         NtdY5OQ/f+ZuO7TB/3ZaB5n9t3/K1i6ueHqoaVX8=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp1.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 4CF2640157;
        Wed, 13 Sep 2023 07:26:12 -0400 (EDT)
Message-ID: <657d4c4c-cf21-4488-8007-a799cfc7632b@mev.co.uk>
Date:   Wed, 13 Sep 2023 12:26:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] comedi: Re-do HAS_IOPORT dependencies
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
References: <20230913112032.90618-1-abbotti@mev.co.uk>
Content-Language: en-GB
Organization: MEV Ltd.
In-Reply-To: <20230913112032.90618-1-abbotti@mev.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 6dfe0409-b725-4570-a1a2-9d7e8033b4cc-1-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2023 12:20, Ian Abbott wrote:
> Commit b5c75b68b7de ("comedi: add HAS_IOPORT dependencies") was reverted
> because it made it impossible to select configuration options that
> depend on the COMEDI_8254, COMEDI_DAS08, COMEDI_NI_LABPC, or
> COMEDI_AMPLC_DIO200 options due to changing 'select' directives to
> 'depends on' directives and there being no other way to select those
> codependent configuration options.
> 
> This patch series conditionally removes port I/O support from various
> comedi modules so they still be built when a future patch removes the
> port I/O functions (inb(), outb() and friends) unless the HAS_IOPORT
> configuration option is selected.  The final patch 13 adds HAS_IOPORT
> dependencies to the configuration options as in the reverted patch, but
> there are now fewer options that need to depend on HAS_IOPORT, and the
> 'select' directives have not been replaced with 'depends on' directives.
> 
> 01) comedi: Correct dependencies for COMEDI_NI_PCIDIO
> 02) comedi: comedi_8254: Use a call-back function for register access
> 03) comedi: comedi_8254: Replace comedi_8254_init() and comedi_8254_mm_init()
> 04) comedi: comedi_8254: Conditionally remove I/O port support
> 05) comedi: 8255_pci: Conditionally remove devices that use port I/O
> 06) comedi: comedi_8255: Rework subdevice initialization functions
> 07) comedi: comedi_8255: Conditionally remove I/O port support
> 08) comedi: ni_labpc_common: Conditionally remove I/O port support
> 09) comedi: ni_mio_common: Conditionally use I/O port or MMIO
> 10) comedi: amplc_dio200_pci: Conditionally remove devices that use port I/O
> 11) comedi: amplc_dio200_common: Refactor register access functions
> 12) comedi: amplc_dio200_common: Conditionally remove I/O port support
> 13) comedi: add HAS_IOPORT dependencies again
> 
>   drivers/comedi/Kconfig                       |  45 +++++-
>   drivers/comedi/drivers.c                     |   3 +-
>   drivers/comedi/drivers/8255.c                |   2 +-
>   drivers/comedi/drivers/8255_pci.c            |  15 +-
>   drivers/comedi/drivers/adl_pci9111.c         |   8 +-
>   drivers/comedi/drivers/adl_pci9118.c         |   8 +-
>   drivers/comedi/drivers/adv_pci1710.c         |   8 +-
>   drivers/comedi/drivers/adv_pci_dio.c         |  14 +-
>   drivers/comedi/drivers/aio_aio12_8.c         |  10 +-
>   drivers/comedi/drivers/amplc_dio200_common.c | 104 +++++++++---
>   drivers/comedi/drivers/amplc_dio200_pci.c    |  12 +-
>   drivers/comedi/drivers/amplc_pc236_common.c  |   2 +-
>   drivers/comedi/drivers/amplc_pci224.c        |   8 +-
>   drivers/comedi/drivers/amplc_pci230.c        |  10 +-
>   drivers/comedi/drivers/cb_das16_cs.c         |   8 +-
>   drivers/comedi/drivers/cb_pcidas.c           |  23 +--
>   drivers/comedi/drivers/cb_pcidas64.c         |   7 +-
>   drivers/comedi/drivers/cb_pcidda.c           |   2 +-
>   drivers/comedi/drivers/cb_pcimdas.c          |  12 +-
>   drivers/comedi/drivers/cb_pcimdda.c          |   2 +-
>   drivers/comedi/drivers/comedi_8254.c         | 234 ++++++++++++++++++---------
>   drivers/comedi/drivers/comedi_8255.c         | 123 +++++++-------
>   drivers/comedi/drivers/daqboard2000.c        |   4 +-
>   drivers/comedi/drivers/das08.c               |  11 +-
>   drivers/comedi/drivers/das16.c               |  10 +-
>   drivers/comedi/drivers/das16m1.c             |  22 +--
>   drivers/comedi/drivers/das1800.c             |   8 +-
>   drivers/comedi/drivers/das6402.c             |   8 +-
>   drivers/comedi/drivers/das800.c              |   8 +-
>   drivers/comedi/drivers/dmm32at.c             |   3 +-
>   drivers/comedi/drivers/me4000.c              |   6 +-
>   drivers/comedi/drivers/ni_at_a2150.c         |   8 +-
>   drivers/comedi/drivers/ni_at_ao.c            |   8 +-
>   drivers/comedi/drivers/ni_atmio16d.c         |   2 +-
>   drivers/comedi/drivers/ni_daq_dio24.c        |   2 +-
>   drivers/comedi/drivers/ni_labpc_common.c     |  51 +++---
>   drivers/comedi/drivers/ni_mio_common.c       |  74 ++++++---
>   drivers/comedi/drivers/pcl711.c              |   8 +-
>   drivers/comedi/drivers/pcl724.c              |   6 +-
>   drivers/comedi/drivers/pcl812.c              |  10 +-
>   drivers/comedi/drivers/pcl816.c              |   8 +-
>   drivers/comedi/drivers/pcl818.c              |   8 +-
>   drivers/comedi/drivers/pcm3724.c             |   2 +-
>   drivers/comedi/drivers/rtd520.c              |   6 +-
>   include/linux/comedi/comedi_8254.h           |  51 ++++--
>   include/linux/comedi/comedi_8255.h           |  24 ++-
>   46 files changed, 649 insertions(+), 359 deletions(-)
> 

Sorry people, I need to repost this series with more Cc: entries because 
I neglected the fact that the git send-email --cc option causes all cc 
lines in the .gitconfig to be ignored!

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

