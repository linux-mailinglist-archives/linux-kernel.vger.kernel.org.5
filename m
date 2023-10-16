Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B597CB706
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjJPXci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPXcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:32:35 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED722AB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:32:32 -0700 (PDT)
Received: from localhost.localdomain (unknown [47.186.13.91])
        by linux.microsoft.com (Postfix) with ESMTPSA id 939A020B74C0;
        Mon, 16 Oct 2023 16:32:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 939A020B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1697499152;
        bh=P7Q7t5ttECRhGuQNGS2wDN67uwAYneX3Je90zVmGQ8k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=iREIZVf8OZ6oWa3x8Rg5Oj6cP4wn3RobB9mGt29plvg0wIY7C1TZ65eb7Csyz55zf
         yUoCOGuL6W22K5ObQVBUw6vpXyIxdJ25Fz6s5UdeTJ+DczmggtPhwVSuhOvlaTEQ4J
         F2Mm8b0pclnrvVitB8BllfXZtI04pfWPCfalr3BQ=
From:   madvenka@linux.microsoft.com
To:     gregkh@linuxfoundation.org, pbonzini@redhat.com, rppt@kernel.org,
        jgowans@amazon.com, graf@amazon.de, arnd@arndb.de,
        keescook@chromium.org, stanislav.kinsburskii@gmail.com,
        anthony.yznaga@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        jamorris@linux.microsoft.com
Subject: [RFC PATCH v1 00/10] mm/prmem: Implement the Persistent-Across-Kexec memory feature (prmem)
Date:   Mon, 16 Oct 2023 18:32:05 -0500
Message-Id: <20231016233215.13090-1-madvenka@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1b1bc25eb87355b91fcde1de7c2f93f38abb2bf9>
References: <1b1bc25eb87355b91fcde1de7c2f93f38abb2bf9>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>

Introduction
============

This feature can be used to persist kernel and user data across kexec reboots
in RAM for various uses. E.g., persisting:

	- cached data. E.g., database caches.
	- state. E.g., KVM guest states.
	- historical information since the last cold boot. E.g., events, logs
	  and journals.
	- measurements for integrity checks on the next boot.
	- driver data.
	- IOMMU mappings.
	- MMIO config information.

This is useful on systems where there is no non-volatile storage or
non-volatile storage is too small or too slow.

The following sections describe the implementation.

I have enhanced the ram disk block device driver to provide persistent ram
disks on which any filesystem can be created. This is for persisting user data.
I have also implemented DAX support for the persistent ram disks.

I am also working on making ZRAM persistent.

I have also briefly discussed the following use cases:

	- Persisting IOMMU mappings
	- Remembering DMA pages
	- Reserving pages that encounter memory errors
	- Remembering IMA measurements for integrity checks
	- Remembering MMIO config info
	- Implementing prmemfs (special filesystem tailored for persistence)

Allocate metadata
=================

Define a metadata structure to store all persistent memory related information.
The metadata fits into one page. On a cold boot, allocate and initialize the
metadata page.

Allocate data
=============

On a cold boot, allocate some memory for storing persistent data. Call it
persistent memory. Specify the size in a command line parameter:

	prmem=size[KMG][,max_size[KMG]]

	size		Initial amount of memory allocated to prmem during boot
	max_size	Maximum amount of memory that can be allocated to prmem

When the initial memory is exhaused via allocations, expand prmem dynamically
up to max_size. Expansion is done by allocating from the buddy allocator.
Record all allocations in the metadata.

Remember the metadata
=====================

On all (kexec) reboots, remember the metadata page address. This is done via
a new kernel command line parameter:

	prmem_meta=address

When a kexec image is loaded, the kexec command line is set up. Append the
above parameter to the command line automatically.

In early boot, extract the metadata page address from the command line and
reserve the metadata page. From the metadata, get the persistent memory that
has been allocated before and reserve it as well.

Manage persistent memory
========================

Manage persistent memory with the Gen Pool allocator (lib/genalloc.c). This
is so we don't have to implement a new allocator. Make the Gen Pool
persistent so allocations can be remembered across kexecs.

Provide functions for allocating and freeing persistent memory. These are
just wrappers around the Gen Pool functions:

  	prmem_alloc_pages()	(looks like alloc_pages())
	prmem_free_pages()	(looks like __free_pages())
	prmem_alloc()		(looks like kmalloc())
	prmem_free()		(looks like kfree())

Create persistent instances
===========================

Consumers store information in the form of data structures. To persist a data
structure across a kexec, a consumer has to do two things:

	1. Allocate persistent memory for the data structure.

	2. Remember the data structure in a named persistent instance.

A persistent instance has the following attributes:

	Subsystem name    Name of the subsystem/module/driver that created the
			  instance. E.g., "ramdisk" for the ramdisk driver.
	Instance name     Name of the instance within the subsystem. E.g.,
			  "pram0" for a persistent ram disk.
	Data		  Pointer to instance data.
	Size		  Size of instance data.

Provide functions to create and manage persistent instances:

	prmem_get()		Get/Create a persistent instance.
	prmem_set_data()	Record the instance data pointer and size.
	prmem_get_data()	Retrieve the instance data pointer and size.
	prmem_put()		Destroy a persistent instance.
	prmem_list()		Enumerate the instances of a subsystem.

Complex data structures
=======================

A persistent instance may have more than one data structure to remember across
kexec.

Data structures can be connected to other data structures using pointers,
arrays, linked lists, RB trees, etc. As long as each structure is placed in
persistent memory, the whole set of data structures can be remembered
across a kexec.

It is expected that a consumer will create a top level data structure for
an instance from which all other data structures belonging to the instance
can be reached. So, only the top level data structure needs to be registered
as instance data.

Linked list nodes and RB nodes are embedded in data structures. So, persisting
linked lists and RB trees is straight forward. But the XArray needs a little
more work. The XArray itself can be embedded in a persistent data structure.
But the XA nodes are currently allocated from normal memory using the kmem
allocator. Enhance XArrays to include a persistent option so that the XA nodes
as well can be allocated from persistent memory. Then, the whole XArray becomes
persistent.

Since Radix Trees are implemented with XArrays, we get persistent Radix
Trees as well.

The ram disk uses an XArray. Some other use cases can also use an XArray.

Persistent virtual addresses
============================

Apart from consumer data structures, Prmem metadata structures must be
persisted as well. In either case, data structures point to one another
using virtual addresses.

To keep the implementation simple, the virtual addresses used within persistent
memory must not change on a kexec. The alternative is to remap everything on
each kexec. This can be complex and cumbersome.

prmem uses direct map addresses for this reason. However, if PAGE_OFFSET is
randomized by KASLR, this will not work. Until I find an alternative for this,
prmem is currently not supported if kernel memory randomization is enabled.
prmem checks for this at runtime and disables itself. So, for now, include
"nokaslr" in the command line to allow prmem.

Note that kernel text randomization does not affect prmem. So, if an
architecture does not support randomization of PAGE_OFFSET, then there is
no need to include "nokaslr" in the command line.

Validation of metadata
======================

The metadata must be validated on a kexec before it can be used. To allow this,
compute a checksum on the metadata just before the kexec reboot and store it in
the metadata.

After kexec, in early boot, use the checksum to validate the metadata. If the
validation fails, discard the metadata. Treat it as a cold boot. That is,
allocate a new metadata page and initial region and start over.

This means that all persistent data will be lost on a validation failure.

Dynamic Expansion
=================

For some use cases, it may be hard to predict how much actual memory is
needed to store persistent data. This may depend on the workload. Either
we would have to overcommit memory for persistent data. Or, we could
allow dynamic expansion of prmem memory.

Implement dynamic expansion of prmem. When there is no free persistent memory
call alloc_pages(MAX_ORDER) to allocate a max order page. Add it to prmem.

Choosing a max order page means that no fragmentation is created for
transparent huge pages or kmem slabs. But fragmentation may be created for
1GB pages. This is not a problem for 1GB pages that are reserved up front
during boot. This could be a problem for 1GB pages that are allocated at run
time dynamically.

As mentioned before, dynamic expansion is optional. If a max_size is not
specified in the command line, then dynamic expansion does not happen.

Persistent Ramdisks
===================

I have implemented one main use case in this patchset - persistent ram disks.
Any filesystem can be installed on a persistent ram disk. User data can be
persisted on the filesystem.

One problem with using a ramdisk is that the page cache will contain redundant
copies of ramdisk pages. To avoid this, I have implemented DAX support for
persistent ramdisks. This can be availed by installing a filesystem with DAX
support on the ram disks.

Normal ramdisk devices are named "ram0", "ram1", "ram2", etc. Persistent
ramdisk devices will be named "pram0", "pram1", "pram2", etc.

For normal ramdisks, ramdisk pages are allocated using alloc_pages(). For
persistent ones, ramdisk pages are allocated using prmem_alloc_pages().

Each ram disk has a device structure (struct brd_device). This is allocated
from kmem for normal ram disks and from persistent memory for persistent ram
disks. This becomes the instance data. This structure contains an XArray
of pages allocated to the ram disk. A persistent XArray will be used.

The disk size for all normal ramdisks is specified via a module parameter
"rd_size". This forces all of the ramdisks to have the same size. For
persistent ram disks, take a different approach. Define a module parameter
called "prd_sizes" which specifies a comma-separated list of sizes. The
sizes are applied in the order in which they appear to "pram0", "pram1",
etc.

	Persistent Ram Disk Usage:

	sudo modprobe brd prd_sizes="1G,2G"

		This creates two persistent ram disks with the specified sizes.
		That is, /dev/pram0 will have a size of 1G. /dev/pram1 will
		have a size of 2G.

	sudo mkfs.ext4 /dev/pram0
	sudo mkfs.ext4 /dev/pram1

		Make filesystems on the persistent ram disks.

	sudo mount -t ext4 /dev/pram0 /path/to/mountpoint0
	sudo mount -t ext4 -o dax /dev/pram1 /path/to/mountpoint1

		Mount them somewhere. Note that the -o dax option can be used
		to avail DAX.

	sudo umount /path/to/mountpoint0
	sudo umount /path/to/mountpoint1

		Unmount the filesystems.

On subsequent kexecs, you can load the module with or without specifying the
sizes. The previous devices and sizes will be remembered. After that, simply
mount the filesystems and use them.

	sudo modprobe brd
	sudo mount -t ext4 /dev/pram0 /path/to/mountpoint0
	sudo mount -t ext4 -o dax /dev/pram1 /path/to/mountpoint1

The persistent ramdisk devices are destroyed when the module is explicitly
unloaded (rmmod). But if a reboot happens without the module unload, the
devices are persisted.

Other use cases
===============

I believe that it is possible to implement most use cases. I have listed some
examples below. I am not an expert in these areas. These are just suggestions.
Please let me know if there are any mistakes. Comments are most welcome.

- IOMMU mappings
	The IOVA to PFN mappings can be remembered using a persistent XArray.

- DMA pages
	Someone mentioned this use case. IIUC, DMA operations may be in flight
	when a kexec happens. Instead of waiting for the DMA operations to
	complete, drivers could remember the DMA pages in a persistent XArray.
	Then, in early boot, retrieve the XArray from prmem and reserve those
	individual pages early. Once the DMA operations complete, the pages can
	be removed from the XArray and freed into the buddy allocator.

- Pages that encounter memory errors
	These could be remembered in a persistent XArray. Then, in early boot,
	retrieve the XArray from prmem and reserve the pages so they are never
	used.

- IMA
	IMA tries to remember measurements across a kexec so that integrity
	checks can be performed on a kexec reboot. Currently, IIUC, IMA
	uses a kexec buffer to remember measurements. However, the buffer
	has to be allocated up front when the kexec image is loaded. If the gap
	between loading a kexec image and executing it is large, the
	measurements that come in during that time may not fit into the
	pre-allocated buffer.

	The solution could be to remember measurements using prmem. I am
	working on this. I will add this in a future version of this patchset.

- ZRAM
	The ZRAM block device is a candidate for persistence. This is still
	work in progress. I will add this in a future version of this patchset
	once I get it working.

- MMIO
	I am not familiar with what exactly needs to be persisted for this.
	I will state my understanding of the use case. Please correct me if
	I am wrong. IIUC, during PCI discovery, I/O devices are enumerated,
	memory space allocation is done and the I/O devices are configured.
	If the enumerated devices and their configuration can be remembered
	across kexec, then the discovery phase can be skipped after kexec.
	This will speed up PCI init.

	I believe the MMIO config info can be persisted using prmem.

- prmemfs
	It may be simpler and more efficient if we could implement a special
	filesystem that is tailored for persistence. We don't have to support
	anything that is not required for persistent data. E.g., FIFOs,
	special files, hard links, using the page cache, etc. When files are
	deleted, the memory can be freed back into prmem.

	The instance data for the filesystem would be the superblock. The
	following need to be allocated from pesistent memory - the superblock,
	the inodes and the data pages. The data pages can be remembered in a
	persistent XArray.

	I am looking into this as well.

TBD
===

- Reservations.
	Consumers must be able to reserve persistent memory to guarantee
	sizes for their instances. E.g., for a persistent ramdisk.

- NUMA support.

- Memory Leak detection.
	Something similar to kmemleak may need to be implemented to detect
	memory leaks in persistent memory.

---

Madhavan T. Venkataraman (10):
  mm/prmem: Allocate memory during boot for storing persistent data
  mm/prmem: Reserve metadata and persistent regions in early boot after
    kexec
  mm/prmem: Manage persistent memory with the gen pool allocator.
  mm/prmem: Implement a page allocator for persistent memory
  mm/prmem: Implement a buffer allocator for persistent memory
  mm/prmem: Implement persistent XArray (and Radix Tree)
  mm/prmem: Implement named Persistent Instances.
  mm/prmem: Implement Persistent Ramdisk instances.
  mm/prmem: Implement DAX support for Persistent Ramdisks.
  mm/prmem: Implement dynamic expansion of prmem.

 arch/x86/kernel/kexec-bzimage64.c |   5 +-
 arch/x86/kernel/setup.c           |   4 +
 drivers/block/Kconfig             |  11 +
 drivers/block/brd.c               | 320 ++++++++++++++++++++++++++++--
 include/linux/genalloc.h          |   6 +
 include/linux/memblock.h          |   2 +
 include/linux/prmem.h             | 158 +++++++++++++++
 include/linux/radix-tree.h        |   4 +
 include/linux/xarray.h            |  15 ++
 kernel/Makefile                   |   1 +
 kernel/prmem/Makefile             |   4 +
 kernel/prmem/prmem_allocator.c    | 222 +++++++++++++++++++++
 kernel/prmem/prmem_init.c         |  48 +++++
 kernel/prmem/prmem_instance.c     | 139 +++++++++++++
 kernel/prmem/prmem_misc.c         |  86 ++++++++
 kernel/prmem/prmem_parse.c        |  80 ++++++++
 kernel/prmem/prmem_region.c       |  87 ++++++++
 kernel/prmem/prmem_reserve.c      | 125 ++++++++++++
 kernel/reboot.c                   |   2 +
 lib/genalloc.c                    |  45 +++--
 lib/radix-tree.c                  |  49 ++++-
 lib/xarray.c                      |  11 +-
 mm/memblock.c                     |  12 ++
 mm/mm_init.c                      |   2 +
 24 files changed, 1400 insertions(+), 38 deletions(-)
 create mode 100644 include/linux/prmem.h
 create mode 100644 kernel/prmem/Makefile
 create mode 100644 kernel/prmem/prmem_allocator.c
 create mode 100644 kernel/prmem/prmem_init.c
 create mode 100644 kernel/prmem/prmem_instance.c
 create mode 100644 kernel/prmem/prmem_misc.c
 create mode 100644 kernel/prmem/prmem_parse.c
 create mode 100644 kernel/prmem/prmem_region.c
 create mode 100644 kernel/prmem/prmem_reserve.c


base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
-- 
2.25.1

