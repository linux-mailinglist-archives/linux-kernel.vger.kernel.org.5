Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338C1792B21
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241527AbjIEQsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354911AbjIEPtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 11:49:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB1E197;
        Tue,  5 Sep 2023 08:49:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3253660919;
        Tue,  5 Sep 2023 15:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12AE0C433C8;
        Tue,  5 Sep 2023 15:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693928984;
        bh=odQno2YjSY2n5UTj6PnQfVPkl1W+8vkvFMiImB6bXb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RjTykYF+ms/bQ+Giy5U4GVXU+wRoxAdEsS7A6LZSF/1DEihYvUfMieeJKI1qVLZZz
         b+g1641Vpg5HHCUTI4kA8VRv/N1z0lzg1Uqm60mFvjx+eVjYQQ/hjr31u1UjKxQOvk
         7QxmeEsS6wZfZBlwwkZL7FH8fG26ULeDt/bSWUF4=
Date:   Tue, 5 Sep 2023 16:49:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ardb@kernel.org, kraxel@redhat.com,
        dovmurik@linux.ibm.com, elena.reshetova@intel.com,
        dave.hansen@linux.intel.com, Dhaval.Giani@amd.com,
        michael.day@amd.com, pavankumar.paluri@amd.com,
        David.Kaplan@amd.com, Reshma.Lal@amd.com, Jeremy.Powell@amd.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        alexander.shishkin@linux.intel.com, thomas.lendacky@amd.com,
        tglx@linutronix.de, dgilbert@redhat.com, dinechin@redhat.com,
        linux-coco@lists.linux.dev, berrange@redhat.com, mst@redhat.com,
        tytso@mit.edu, jikos@kernel.org, joro@8bytes.org, leon@kernel.org,
        richard.weinberger@gmail.com, lukas@wunner.de, jejb@linux.ibm.com,
        cdupontd@redhat.com, jasowang@redhat.com, sameo@rivosinc.com,
        bp@alien8.de, seanjc@google.com, security@kernel.org,
        Larry Dewey <larry.dewey@amd.com>
Subject: Re: [PATCH v4] docs: security: Confidential computing intro and
 threat model for x86 virtualization
Message-ID: <2023090537-undesired-junction-b325@gregkh>
References: <20230905152656.1215119-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230905152656.1215119-1-carlos.bilbao@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 10:26:56AM -0500, Carlos Bilbao wrote:
> +In the following diagram, the "<--->" lines represent bi-directional
> +communication channels or interfaces between the CoCo security manager and
> +the rest of the components (data flow for guest, host, hardware) ::
> +
> +    +-------------------+      +-----------------------+
> +    | CoCo guest VM     |<---->|                       |
> +    +-------------------+      |                       |
> +      | Interfaces |           | CoCo security manager |
> +    +-------------------+      |                       |
> +    | Host VMM          |<---->|                       |
> +    +-------------------+      |                       |
> +                               |                       |
> +    +--------------------+     |                       |
> +    | CoCo platform      |<--->|                       |
> +    +--------------------+     +-----------------------+

I don't understand what "| Interfaces |" means here.  There is, or is
not, a communication channel between the CoC guest VM and the Host VMM?

What does "interface" mean?

> +
> +The specific details of the CoCo security manager vastly diverge between
> +technologies. For example, in some cases, it will be implemented in HW
> +while in others it may be pure SW.
> +
> +Existing Linux kernel threat model
> +==================================
> +
> +The overall components of the current Linux kernel threat model are::
> +
> +     +-----------------------+      +-------------------+
> +     |                       |<---->| Userspace         |
> +     |                       |      +-------------------+
> +     |   External attack     |         | Interfaces |
> +     |       vectors         |      +-------------------+
> +     |                       |<---->| Linux Kernel      |
> +     |                       |      +-------------------+
> +     +-----------------------+      +-------------------+
> +                                    | Bootloader/BIOS   |
> +                                    +-------------------+
> +                                    +-------------------+
> +                                    | HW platform       |
> +                                    +-------------------+


Same here, what does "Interfaces" mean?

And external attack vectors can't get to the kernel without going
through userspace (or the HW platform), right?

> +There is also communication between the bootloader and the kernel during
> +the boot process, but this diagram does not represent it explicitly. The
> +"Interfaces" box represents the various interfaces that allow
> +communication between kernel and userspace. This includes system calls,
> +kernel APIs, device drivers, etc.

Ah, you define that here now.

But the kernel talks to the Bootloader/BIOS after things are up and
running all the time.

Same goes with the HW platform, the kernel talks to it too.

> +The existing Linux kernel threat model typically assumes execution on a
> +trusted HW platform with all of the firmware and bootloaders included on
> +its TCB. The primary attacker resides in the userspace, and all of the data
> +coming from there is generally considered untrusted, unless userspace is
> +privileged enough to perform trusted actions. In addition, external
> +attackers are typically considered, including those with access to enabled
> +external networks (e.g. Ethernet, Wireless, Bluetooth), exposed hardware
> +interfaces (e.g. USB, Thunderbolt), and the ability to modify the contents
> +of disks offline.

Ok, but again, your diagram is odd, the text seems correct though.

> +Regarding external attack vectors, it is interesting to note that in most
> +cases external attackers will try to exploit vulnerabilities in userspace
> +first, but that it is possible for an attacker to directly target the
> +kernel; particularly if the host has physical access. Examples of direct
> +kernel attacks include the vulnerabilities CVE-2019-19524, CVE-2022-0435
> +and CVE-2020-24490.
> +
> +Confidential Computing threat model and its security objectives
> +===============================================================
> +
> +Confidential Computing adds a new type of attacker to the above list: a
> +potentially misbehaving host (which can also include some part of a
> +traditional VMM or all of it), which is typically placed outside of the
> +CoCo VM TCB due to its large SW attack surface. It is important to note
> +that this doesn’t imply that the host or VMM are intentionally
> +malicious, but that there exists a security value in having a small CoCo
> +VM TCB. This new type of adversary may be viewed as a more powerful type
> +of external attacker, as it resides locally on the same physical machine
> +(in contrast to a remote network attacker) and has control over the guest
> +kernel communication with most of the HW::
> +
> +                                 +------------------------+
> +                                 |    CoCo guest VM       |
> +   +-----------------------+     |  +-------------------+ |
> +   |                       |<--->|  | Userspace         | |
> +   |                       |     |  +-------------------+ |
> +   |   External attack     |     |     | Interfaces |     |
> +   |       vectors         |     |  +-------------------+ |
> +   |                       |<--->|  | Linux Kernel      | |
> +   |                       |     |  +-------------------+ |
> +   +-----------------------+     |  +-------------------+ |
> +                                 |  | Bootloader/BIOS   | |
> +   +-----------------------+     |  +-------------------+ |
> +   |                       |<--->+------------------------+
> +   |                       |          | Interfaces |
> +   |                       |     +------------------------+
> +   |     CoCo security     |<--->| Host/Host-side VMM |
> +   |      manager          |     +------------------------+
> +   |                       |     +------------------------+
> +   |                       |<--->|   CoCo platform        |
> +   +-----------------------+     +------------------------+
> +
> +While traditionally the host has unlimited access to guest data and can
> +leverage this access to attack the guest, the CoCo systems mitigate such
> +attacks by adding security features like guest data confidentiality and
> +integrity protection. This threat model assumes that those features are
> +available and intact.
> +
> +The **Linux kernel CoCo VM security objectives** can be summarized as follows:
> +
> +1. Preserve the confidentiality and integrity of CoCo guest's private
> +memory and registers.

Preserve it from whom?

> +2. Prevent privileged escalation from a host into a CoCo guest Linux kernel.
> +While it is true that the host (and host-side VMM) requires some level of
> +privilege to create, destroy, or pause the guest, part of the goal of
> +preventing privileged escalation is to ensure that these operations do not
> +provide a pathway for attackers to gain access to the guest's kernel.
> +
> +The above security objectives result in two primary **Linux kernel CoCo
> +VM assets**:
> +
> +1. Guest kernel execution context.
> +2. Guest kernel private memory.
> +
> +The host retains full control over the CoCo guest resources, and can deny
> +access to them at any time. Examples of resources include CPU time, memory
> +that the guest can consume, network bandwidth, etc. Because of this, the
> +host Denial of Service (DoS) attacks against CoCo guests are beyond the
> +scope of this threat model.
> +
> +The **Linux CoCo VM attack surface** is any interface exposed from a CoCo
> +guest Linux kernel towards an untrusted host that is not covered by the
> +CoCo technology SW/HW protection. This includes any possible
> +side-channels, as well as transient execution side channels. Examples of
> +explicit (not side-channel) interfaces include accesses to port I/O, MMIO
> +and DMA interfaces, access to PCI configuration space, VMM-specific
> +hypercalls (towards Host-side VMM), access to shared memory pages,
> +interrupts allowed to be injected into the guest kernel by the host, as
> +well as CoCo technology-specific hypercalls, if present. Additionally, the
> +host in a CoCo system typically controls the process of creating a CoCo
> +guest: it has a method to load into a guest the firmware and bootloader
> +images, the kernel image together with the kernel command line. All of this
> +data should also be considered untrusted until its integrity and
> +authenticity is established via attestation.
> +
> +The table below shows a threat matrix for the CoCo guest Linux kernel but
> +does not discuss potential mitigation strategies. The matrix refers to
> +CoCo-specific versions of the guest, host and platform.
> +
> +.. list-table:: CoCo Linux guest kernel threat matrix
> +   :widths: auto
> +   :align: center
> +   :header-rows: 1
> +
> +   * - Threat name
> +     - Threat description
> +
> +   * - Guest malicious configuration
> +     - A misbehaving host modifies one of the following guest's
> +       configuration:
> +
> +       1. Guest firmware or bootloader
> +
> +       2. Guest kernel or module binaries
> +
> +       3. Guest command line parameters
> +
> +       This allows the host to break the integrity of the code running
> +       inside a CoCo guest, and violates the CoCo security objectives.
> +
> +   * - CoCo guest data attacks
> +     - A misbehaving host retains full control of the CoCo guest's data
> +       in-transit between the guest and the host-managed physical or
> +       virtual devices. This allows any attack against confidentiality,
> +       integrity or freshness of such data.
> +
> +   * - Malformed runtime input
> +     - A misbehaving host injects malformed input via any communication
> +       interface used by the guest's kernel code. If the code is not
> +       prepared to handle this input correctly, this can result in a host
> +       --> guest kernel privilege escalation. This includes traditional
> +       side-channel and/or transient execution attack vectors.

ok, good luck with that!  side-channel attack vectors are going to be
interesting for you to attempt to handle.

Anyway, you are setting yourself up to treat ALL data coming into any
kernel interface as potentially malicious, right?  I welcome the patches
to all of the drivers you are using to attempt to handle this properly,
and to cover the performance impact that it is going to cause (check all
the disk i/o packets!)  Good Luck!

greg k-h
