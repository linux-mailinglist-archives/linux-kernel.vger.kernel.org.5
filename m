Return-Path: <linux-kernel+bounces-14553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEA5821E9E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04B01C2247D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E171429F;
	Tue,  2 Jan 2024 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqEPk9zN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D68113AE9;
	Tue,  2 Jan 2024 15:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335A1C433C8;
	Tue,  2 Jan 2024 15:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704208826;
	bh=28yPedgGByxBs/XllHPUgTPObBuags0avxhjHUIO2lA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SqEPk9zNaSyGDVA+YezzLsKj3ZNQGZ0SC4yCM9VyBETW2lskULwf3YW1bzCtNQIfP
	 6uXhHnR+VyjNxAdfsAuGy3PHqdk6b8MxmTW8LYv8wBb4ItzWZw49ksPEkR06n89PFp
	 2SHwc5dxr4TpgSfLoEJwYJVg/H6eXbQixr64Xmfg+I5UB0X4IH3NAAjmjbwdHFlysM
	 UpyPsK4q/fnx9eBausPSz+cLglyeXqhW6ZWKNvjm1TKrQumi+l1lHl2hw3OUh/RrfO
	 moE9dADO9rGte6dRtTv4Lf6g34Xmghec8dAzDY6uXDe6/E/fPOAc7PHu2mFtiS2u5m
	 S8IIs3i6VEKvg==
Received: (nullmailer pid 2861879 invoked by uid 1000);
	Tue, 02 Jan 2024 15:20:23 -0000
Date: Tue, 2 Jan 2024 08:20:23 -0700
From: Rob Herring <robh@kernel.org>
To: Alexander Graf <graf@amazon.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, linux-doc@vger.kernel.org, x86@kernel.org, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>, Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, arnd@arndb.de, pbonzini@redhat.com, madvenka@linux.microsoft.com, Anthony Yznaga <anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, David Woodhouse <dwmw@amazon.co.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 17/17] devicetree: Add bindings for ftrace KHO
Message-ID: <20240102152023.GA2821956-robh@kernel.org>
References: <20231222193607.15474-1-graf@amazon.com>
 <20231222195144.24532-1-graf@amazon.com>
 <20231222195144.24532-12-graf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222195144.24532-12-graf@amazon.com>

On Fri, Dec 22, 2023 at 07:51:44PM +0000, Alexander Graf wrote:
> With ftrace in KHO, we are creating an ABI between old kernel and new
> kernel about the state that they transfer. To ensure that we document
> that state and catch any breaking change, let's add its schema to the
> common devicetree bindings. This way, we can quickly reason about the
> state that gets passed.

Why so much data in DT rather than putting all this information into 
memory in your own data structure and DT just has a single property 
pointing to that? That's what is done with every other blob of data 
passed by kexec.

> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>  .../bindings/kho/ftrace/ftrace-array.yaml     | 46 +++++++++++++++
>  .../bindings/kho/ftrace/ftrace-cpu.yaml       | 56 +++++++++++++++++++
>  .../bindings/kho/ftrace/ftrace.yaml           | 48 ++++++++++++++++
>  3 files changed, 150 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/kho/ftrace/ftrace-array.yaml
>  create mode 100644 Documentation/devicetree/bindings/kho/ftrace/ftrace-cpu.yaml
>  create mode 100644 Documentation/devicetree/bindings/kho/ftrace/ftrace.yaml
> 
> diff --git a/Documentation/devicetree/bindings/kho/ftrace/ftrace-array.yaml b/Documentation/devicetree/bindings/kho/ftrace/ftrace-array.yaml
> new file mode 100644
> index 000000000000..9960fefc292d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/kho/ftrace/ftrace-array.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/kho/ftrace/ftrace-array.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ftrace trace array
> +
> +maintainers:
> +  - Alexander Graf <graf@amazon.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ftrace,array-v1
> +
> +  trace_flags:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Bitmap of all the trace flags that were enabled in the trace array at the
> +      point of serialization.
> +
> +# Subnodes will be of type "ftrace,cpu-v1", one each per CPU

This can be expressed as a schema.

> +additionalProperties: true
> +
> +required:
> +  - compatible
> +  - trace_flags
> +
> +examples:
> +  - |
> +    ftrace {
> +        compatible = "ftrace-v1";
> +        events = <1 1 2 2 3 3>;
> +
> +        global_trace {
> +          compatible = "ftrace,array-v1";
> +          trace_flags = < 0x3354601 >;
> +
> +          cpu0 {
> +            compatible = "ftrace,cpu-v1";
> +            cpu = < 0x00 >;
> +            mem = < 0x101000000ULL 0x38ULL 0x101000100ULL 0x1000ULL 0x101000038ULL 0x38ULL 0x101002000ULL 0x1000ULL>;
> +          };
> +        };
> +      };
> diff --git a/Documentation/devicetree/bindings/kho/ftrace/ftrace-cpu.yaml b/Documentation/devicetree/bindings/kho/ftrace/ftrace-cpu.yaml
> new file mode 100644
> index 000000000000..58c715e93f37
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/kho/ftrace/ftrace-cpu.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/kho/ftrace/ftrace-cpu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ftrace per-CPU ring buffer contents
> +
> +maintainers:
> +  - Alexander Graf <graf@amazon.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ftrace,cpu-v1
> +
> +  cpu:
> +    $ref: /schemas/types.yaml#/definitions/uint32

'cpu' is already a defined property of type 'phandle'. While we can have 
multiple types for a given property name, best practice is to avoid 
that. The normal way to refer to a CPU would be a phandle to the CPU 
node, but I can see that might not make sense here.

"CPU numbers" on arm64 are 64-bit values as well as they are the 
CPU's MPIDR value. 

> +    description:
> +      CPU number of the CPU that this ring buffer belonged to when it was
> +      serialized.
> +
> +  mem:

Too vague. Make the property name indicate what's in the memory.

> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      Array of { u64 phys_addr, u64 len } elements that describe a list of ring
> +      buffer pages. Each page consists of two elements. The first element
> +      describes the location of the struct buffer_page that contains metadata
> +      for a given ring buffer page, such as the ring's head indicator. The
> +      second element points to the ring buffer data page which contains the raw
> +      trace data.
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - cpu
> +  - mem
> +
> +examples:
> +  - |
> +    ftrace {
> +        compatible = "ftrace-v1";
> +        events = <1 1 2 2 3 3>;
> +
> +        global_trace {
> +          compatible = "ftrace,array-v1";
> +          trace_flags = < 0x3354601 >;
> +
> +          cpu0 {
> +            compatible = "ftrace,cpu-v1";
> +            cpu = < 0x00 >;
> +            mem = < 0x101000000ULL 0x38ULL 0x101000100ULL 0x1000ULL 0x101000038ULL 0x38ULL 0x101002000ULL 0x1000ULL>;
> +          };
> +        };
> +      };
> diff --git a/Documentation/devicetree/bindings/kho/ftrace/ftrace.yaml b/Documentation/devicetree/bindings/kho/ftrace/ftrace.yaml
> new file mode 100644
> index 000000000000..b87a64843af3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/kho/ftrace/ftrace.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/kho/ftrace/ftrace.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ftrace core data
> +
> +maintainers:
> +  - Alexander Graf <graf@amazon.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ftrace-v1
> +
> +  events:

Again, too vague.

> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      Array of { u32 crc, u32 type } elements. Each element contains a unique
> +      identifier for an event, followed by the identifier that this event had
> +      in the previous kernel's trace buffers.
> +
> +# Other child nodes will be of type "ftrace,array-v1". Each of which describe
> +# a trace buffer
> +additionalProperties: true
> +
> +required:
> +  - compatible
> +  - events
> +
> +examples:
> +  - |
> +    ftrace {

This should go under /chosen. Show that here. Start the example with 
'/{' to do that and not add the usual boilerplate we add when extracting 
the examples.

Also, we don't need 3 examples. Just do 1 complete example here.


> +        compatible = "ftrace-v1";
> +        events = <1 1 2 2 3 3>;
> +
> +        global_trace {
> +          compatible = "ftrace,array-v1";
> +          trace_flags = < 0x3354601 >;
> +
> +          cpu0 {
> +            compatible = "ftrace,cpu-v1";
> +            cpu = < 0x00 >;
> +            mem = < 0x101000000ULL 0x38ULL 0x101000100ULL 0x1000ULL 0x101000038ULL 0x38ULL 0x101002000ULL 0x1000ULL>;
> +          };
> +        };
> +      };
> -- 
> 2.40.1
> 
> 
> 
> 
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
> 
> 
> 

