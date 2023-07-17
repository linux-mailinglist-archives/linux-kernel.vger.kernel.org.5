Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676FD755ACD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 07:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjGQFN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 01:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjGQFNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 01:13:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FCDE63
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 22:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689570760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XpPl7D+YyowuSTqvPnZdoj0YXyM0k/RzKfcV3mHh1uY=;
        b=bS613Lp1OXb5Nk4KHox6vm5hH8BszHKxcswc83qfdFP9ntlQSQgq8M8RX+JPgXyNwxUTB/
        lFjXIXOlab3MAVDCFvBmOd3NPH5zWNeMvWOUa4shfoV2AUNjqukaryfgV76fsawRHh5tL8
        wKLnMvpb+2uZ1Iv+QeqMohbUoMPb37w=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-njS9aJpsM_mqeUBJe_j8Fg-1; Mon, 17 Jul 2023 01:12:39 -0400
X-MC-Unique: njS9aJpsM_mqeUBJe_j8Fg-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1ba6eca72e0so1980302fac.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 22:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689570758; x=1692162758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XpPl7D+YyowuSTqvPnZdoj0YXyM0k/RzKfcV3mHh1uY=;
        b=C0I+ENCjLDvi/Xn54etPmnS2P6XyxpCueWcyTaJzD5tj0PS2G+t4nwD2gfilG/M+nX
         u0gDd5Xo8wZ9fyI/zvOJYxWPrAHcCcEC8Qnp16NZeb+0KUKsAg2LgP8DH1D+9oShJ6YW
         cNcushM/fyMVfnml+dv/RwJ9zwrKgAXDjq4ORoDn104EGX+7+Y/gALLGH7uMd0B7Bt32
         eRX3LgeCPTfbwb97AX2upFdBIFtcc6AvmrAAcPIVnhOIHDSbSFiSaMuJiWnv/t1rsZbc
         KHu6S0nQB4uwm6gMGbNh2HPiRZ5tKUOxKMpHdBaHaNF79PRtuU7UTbN1UADonUAJEus2
         RFmQ==
X-Gm-Message-State: ABy/qLYCRE2jJ9+zfoiybh762jWHoXRSbKSbY5gIA2UYvyJ6qRboG9Ng
        lwTfrzOfKayvH0DuXAErDdlqV/QXKu8P2aD1ySszBpMeAxAkj+PExyLh0rHixhJPVstxyChA/Ho
        v6mk2ZM804rBgQJUjlJ8QZjJDBOPvI2RJHA2gms5JxaXubGlwTPU=
X-Received: by 2002:a05:6870:2d4:b0:1b3:ec6b:b264 with SMTP id r20-20020a05687002d400b001b3ec6bb264mr12384795oaf.5.1689570758677;
        Sun, 16 Jul 2023 22:12:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEhv8PmsM82bP4te8cHd92PfJoaIOIdUOnlQPVX0Ctase4wozNPYJ1aosaCxbjVD/0Z0bfNV4Aof5r+kG80NEQ=
X-Received: by 2002:a05:6870:2d4:b0:1b3:ec6b:b264 with SMTP id
 r20-20020a05687002d400b001b3ec6bb264mr12384786oaf.5.1689570758330; Sun, 16
 Jul 2023 22:12:38 -0700 (PDT)
MIME-Version: 1.0
From:   Costa Shulyupin <costa.shul@redhat.com>
Date:   Mon, 17 Jul 2023 08:12:27 +0300
Message-ID: <CADDUTFyArtN--_27xLWpqnBM2e_udmL+E6Ka7KgimTUOguWthg@mail.gmail.com>
Subject: confusing changes in the documentation table of contents
To:     linux-doc@vger.kernel.org, kernelnewbies@kernelnewbies.org,
        Jonathan Corbet <corbet@lwn.net>
Cc:     open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In https://www.kernel.org/doc/html/v6.2/ Table of Contents consisted
of 10 items. It was compact, organized and observable:

The Linux Kernel documentation
- Working with the development community
- Internal API manuals
- Development tools and processes
- User-oriented documentation
- Firmware-related documentation
- Architecture-specific documentation
- Other documentation
- Translations
Indices and tables

Since  https://www.kernel.org/doc/html/v6.3/ it consists of 60+ items.
Now it is long, unorganized and unobservable:

A guide to the Kernel Development Process
Submitting patches: the essential guide to getting your code into the kerne=
l
Code of conduct
Kernel Maintainer Handbook
All development-process docs

Linux kernel licensing rules
HOWTO do Linux kernel development
Contributor Covenant Code of Conduct
Linux Kernel Contributor Covenant Code of Conduct Interpretation
A guide to the Kernel Development Process
Submitting patches: the essential guide to getting your code into the kerne=
l
Handling regressions
Programming Language
Linux kernel coding style
Subsystem and maintainer tree specific development process notes
Kernel Maintainer PGP guide
Email clients info for Linux
Linux Kernel Enforcement Statement
Kernel Driver Statement
Security bugs
Embargoed hardware issues
Minimal requirements to compile the Kernel
The Linux Kernel Driver Interface
Linux kernel management style
Everything you ever wanted to know about Linux -stable releases
Linux Kernel patch submission checklist
Index of Further Kernel Documentation
Deprecated Interfaces, Language Features, Attributes, and Conventions
List of maintainers and how to submit kernel changes
Researcher Guidelines
Applying Patches To The Linux Kernel
Adding a New System Call
Linux magic numbers
Why the =E2=80=9Cvolatile=E2=80=9D type class should not be used
(How to avoid) Botching up ioctls
clang-format
arch/riscv maintenance guidelines for developers
Unaligned Memory Accesses

Core API Documentation
Driver implementer=E2=80=99s API guide
Kernel subsystem documentation
Locking in the kernel

Linux kernel licensing rules
How to write kernel documentation
Development tools for the kernel
Kernel Testing Guide
Kernel Hacking Guides
Linux Tracing Technologies
fault-injection
Kernel Livepatching
Rust

The Linux kernel user=E2=80=99s and administrator=E2=80=99s guide
The kernel build system
Reporting issues
User-space tools
The Linux kernel user-space API guide

The Linux kernel firmware guide
Open Firmware and Devicetree

CPU Architectures

Unsorted Documentation

Questions:
- Why?
- What are further plans?
- What to do?

Thanks,
Costa

