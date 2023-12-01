Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92458016D5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 23:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjLAWpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 17:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAWpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 17:45:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6E5E0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 14:45:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7810CC433C7;
        Fri,  1 Dec 2023 22:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701470758;
        bh=mCohPRAX+vrdHwTJQfgkUwLwKKdD+fr/q27He1nuF8E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Kx1uGmM9g+AIj3wuXBYWMCmQc9JPLjuznc9FaYjduL06/UxSMwuS8ZN7X/yHVTnCD
         WokxVBc+afmbzOK1IXvBwaMbSVcetA7WC9BhkiWjLVefqDhR0ZvnFcHEuGe35jQf+S
         IURMlnW9WmH++LEenQOz1HU4fVh+/NNVMDiUhUbaMuSnshQFxjVNqH8bRpJmEzSHCs
         4centAtD1uaulNfuu66PXGaTzLujuEVPIHiiUWoQoVYRqje9rTG2+ko6aF+23nvHhc
         nBTVHL8ZeulJ9judD0RjvheDiMGblkuL0zhKYgCKdTmvz7lzc5o7Auh2O/ZjzVyZsa
         dHxqFZTpv1WmQ==
Date:   Fri, 1 Dec 2023 16:45:56 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Herve Codina <herve.codina@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>,
        Sonal Santan <sonal.santan@amd.com>,
        Stefano Stabellini <stefano.stabellini@xilinx.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 0/2] Attach DT nodes to existing PCI devices
Message-ID: <20231201224556.GA534342@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJvt6FpXK+FgAwE8xN3G5Z23Ktq=SEY-K7VA7nM5XgZRg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 04:26:45PM -0600, Rob Herring wrote:
> On Thu, Nov 30, 2023 at 10:57 AM Herve Codina <herve.codina@bootlin.com> wrote:
> ...

> Also, no idea if the bridge part works because my qemu setup doesn't
> create bridges (anyone got a magic cmdline to create them?).

I probably copied this from somewhere and certainly couldn't construct
it from scratch, but it did create a hierarchy like this:

  00:04.0 bridge to [bus 01-04] (Root Port)
  01:00.0 bridge to [bus 02-04] (Switch Upstream Port)
  02:00.0 bridge to [bus 03] (Switch Downstream Port)
  02:01.0 bridge to [bus 04] (Switch Downstream Port)
  03:00.0 endpoint
  04:00.0 endpoint

  IMAGE=ubuntu.img
  KERNEL=~/linux/arch/x86/boot/bzImage
  IMGDIR=~/virt/img/

  qemu-system-x86_64 -enable-kvm -s -m 2048 $IMAGE \
      -device pcie-root-port,id=root_port1,chassis=1,slot=1 \
      -device x3130-upstream,id=upstream_port1,bus=root_port1 \
      -device xio3130-downstream,id=downstream_port1,bus=upstream_port1,chassis=2,slot=1 \
      -device xio3130-downstream,id=downstream_port2,bus=upstream_port1,chassis=2,slot=2 \
      -drive file=${IMGDIR}/nvme.qcow2,if=none,id=nvme1,snapshot=on \
      -device nvme,drive=nvme1,serial=nvme1,cmb_size_mb=2048,bus=downstream_port1 \
      -drive file=${IMGDIR}/nvme2.qcow2,if=none,id=nvme2,snapshot=on \
      -device nvme,drive=nvme2,serial=nvme1,bus=downstream_port2 \
      -virtfs local,id=home,path=/home/,security_model=mapped,mount_tag=home \
      -nographic \
      -kernel $KERNEL \
      -append "root=/dev/sda2 rootfstype=ext4 console=ttyS0,38400n8"
